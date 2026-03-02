package com.example.shop.config;

import com.example.shop.domain.Cart;
import com.example.shop.service.CustomUserDetailsService;
import com.example.shop.service.ProductService;
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

    // Vẫn giữ ProductService để lấy thông tin giỏ hàng lúc login thường
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

            // Tự động đếm và lưu số lượng giỏ hàng vào session khi đăng nhập thành công
            Cart cart = productService.fetchCartByUserEmail(email);
            int sum = (cart != null) ? cart.getSum() : 0;
            session.setAttribute("sum", sum);

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
                        // Đã thêm /policy/** để người dùng xem được trang chi tiết chính sách
                        .requestMatchers("/css/**", "/js/**", "/images/**", "/product/**", "/client/**",
                                "/resources/**", "/policy/**")
                        .permitAll()
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