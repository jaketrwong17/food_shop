/*package com.example.shop.config;

import com.example.shop.service.CustomUserDetailsService;
import com.example.shop.service.UserService;
import jakarta.servlet.DispatcherType;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.csrf.CsrfTokenRequestAttributeHandler;

import java.util.Collection;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    // 1. Tiêm (Inject) bộ xử lý lỗi tùy chỉnh vừa tạo
    @Autowired
    private CustomAuthenticationFailureHandler customAuthenticationFailureHandler;

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public UserDetailsService userDetailsService(UserService userService) {
        return new CustomUserDetailsService(userService);
    }

    @Bean
    public DaoAuthenticationProvider authProvider(
            PasswordEncoder passwordEncoder,
            UserDetailsService userDetailsService) {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailsService);
        authProvider.setPasswordEncoder(passwordEncoder);
        return authProvider;
    }

    @Bean
    public AuthenticationSuccessHandler customSuccessHandler() {
        return (request, response, authentication) -> {
            HttpSession session = request.getSession();
            String email = authentication.getName();
            session.setAttribute("email", email);

            // Xử lý Role để redirect sau khi login thành công
            Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
            String role = "";
            if (!authorities.isEmpty()) {
                role = authorities.iterator().next().getAuthority();
            }
            if (role.startsWith("ROLE_")) {
                role = role.substring(5);
            }
            session.setAttribute("role", role);
            response.sendRedirect("/");
        };
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http, AuthenticationSuccessHandler successHandler)
            throws Exception {
        http
                .csrf(csrf -> csrf.csrfTokenRequestHandler(new CsrfTokenRequestAttributeHandler()))
                .authorizeHttpRequests(authorize -> authorize
                        .dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.INCLUDE).permitAll()
                        .requestMatchers("/css/**", "/js/**", "/images/**", "/product/**", "/client/**").permitAll()
                        .requestMatchers("/", "/login", "/register", "/verify", "/forgot-password", "/reset-password")
                        .permitAll()
                        .requestMatchers("/admin/**").hasRole("ADMIN")
                        .anyRequest().authenticated())

                .formLogin(form -> form
                        .loginPage("/login")
                        .loginProcessingUrl("/login")
                        .successHandler(successHandler)

                        // --- THAY ĐỔI Ở ĐÂY ---
                        // Cũ: .failureUrl("/login?error")
                        // Mới: Sử dụng Handler để phân loại lỗi (Khóa vs Sai pass)
                        .failureHandler(customAuthenticationFailureHandler)
                        // ---------------------

                        .permitAll())
                .logout(logout -> logout
                        .logoutSuccessUrl("/")
                        .permitAll());

        return http.build();
    }
}*/
package com.example.shop.config;

import com.example.shop.domain.Cart;
import com.example.shop.service.CustomUserDetailsService;
import com.example.shop.service.ProductService;
import com.example.shop.service.UserService;
import jakarta.servlet.DispatcherType;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.csrf.CsrfTokenRequestAttributeHandler;

import java.util.Collection;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Autowired
    private CustomAuthenticationFailureHandler customAuthenticationFailureHandler;

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public UserDetailsService userDetailsService(UserService userService) {
        return new CustomUserDetailsService(userService);
    }

    @Bean
    public DaoAuthenticationProvider authProvider(
            PasswordEncoder passwordEncoder,
            UserDetailsService userDetailsService) {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailsService);
        authProvider.setPasswordEncoder(passwordEncoder);
        return authProvider;
    }

    // SỬA: Inject ProductService để lấy thông tin giỏ hàng lúc login thường
    @Bean
    public AuthenticationSuccessHandler customSuccessHandler(ProductService productService) {
        return (request, response, authentication) -> {
            HttpSession session = request.getSession();
            String email = authentication.getName();
            session.setAttribute("email", email);

            Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
            String role = "";
            if (!authorities.isEmpty()) {
                role = authorities.iterator().next().getAuthority();
            }
            if (role.startsWith("ROLE_")) {
                role = role.substring(5);
            }
            session.setAttribute("role", role);

            // Tự động đếm và lưu số lượng giỏ hàng vào session
            Cart cart = productService.fetchCartByUserEmail(email);
            int sum = (cart != null) ? cart.getSum() : 0;
            session.setAttribute("sum", sum);

            response.sendRedirect("/");
        };
    }

    // SỬA: Inject thêm ProductService vào filterChain để dùng cho Auto Login
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http, AuthenticationSuccessHandler successHandler,
            UserDetailsService userDetailsService, ProductService productService)
            throws Exception {

        // =========================================================================
        // BỘ LỌC TỰ ĐỘNG ĐĂNG NHẬP (AUTO LOGIN) CHO MỤC ĐÍCH TEST
        // =========================================================================
        Filter autoLoginFilter = (ServletRequest request, ServletResponse response, FilterChain chain) -> {
            HttpServletRequest req = (HttpServletRequest) request;
            if (SecurityContextHolder.getContext().getAuthentication() == null ||
                    SecurityContextHolder.getContext().getAuthentication().getName().equals("anonymousUser")) {
                try {
                    String adminEmail = "admin@gmail.com";
                    UserDetails user = userDetailsService.loadUserByUsername(adminEmail);
                    if (user != null) {
                        UsernamePasswordAuthenticationToken auth = new UsernamePasswordAuthenticationToken(user, null,
                                user.getAuthorities());
                        SecurityContextHolder.getContext().setAuthentication(auth);

                        req.getSession().setAttribute("email", adminEmail);
                        req.getSession().setAttribute("role", "ADMIN");

                        // Tự động đếm và lưu số lượng giỏ hàng cho tài khoản Auto Login
                        Cart cart = productService.fetchCartByUserEmail(adminEmail);
                        int sum = (cart != null) ? cart.getSum() : 0;
                        req.getSession().setAttribute("sum", sum);
                    }
                } catch (Exception e) {
                    System.out.println("Tự động đăng nhập thất bại: " + e.getMessage());
                }
            }
            chain.doFilter(request, response);
        };
        http.addFilterBefore(autoLoginFilter, UsernamePasswordAuthenticationFilter.class);
        // =========================================================================

        http
                // SỬA: Bật lại CSRF theo chuẩn cũ để Javascript trang Admin chạy được
                .csrf(csrf -> csrf.csrfTokenRequestHandler(new CsrfTokenRequestAttributeHandler()))

                .authorizeHttpRequests(authorize -> authorize
                        .dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.INCLUDE).permitAll()
                        .requestMatchers("/css/**", "/js/**", "/images/**", "/product/**", "/client/**").permitAll()
                        .requestMatchers("/", "/login", "/register", "/verify", "/forgot-password", "/reset-password")
                        .permitAll()
                        .requestMatchers("/admin/**").hasRole("ADMIN")
                        .anyRequest().authenticated())

                .formLogin(form -> form
                        .loginPage("/login")
                        .loginProcessingUrl("/login")
                        .successHandler(successHandler)
                        .failureHandler(customAuthenticationFailureHandler)
                        .permitAll())
                .logout(logout -> logout
                        .logoutSuccessUrl("/")
                        .permitAll());

        return http.build();
    }
}