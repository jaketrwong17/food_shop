package com.example.shop.service;

import com.example.shop.domain.Category;
import com.example.shop.domain.Voucher;
import com.example.shop.repository.VoucherRepository;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class VoucherService {

    private final VoucherRepository voucherRepository;
    private final CategoryService categoryService;

    public VoucherService(VoucherRepository voucherRepository, CategoryService categoryService) {
        this.voucherRepository = voucherRepository;
        this.categoryService = categoryService;
    }

    public List<Voucher> getAllVouchers() {
        return this.voucherRepository.findAll();
    }

    public void handleSaveVoucher(Voucher voucher, List<Long> categoryIds) {
        if (categoryIds != null && !voucher.isAll()) {
            List<Category> cats = new ArrayList<>();
            for (Long id : categoryIds) {

                cats.add(this.categoryService.getCategoryById(id));
            }
            voucher.setCategories(cats);
        }
        this.voucherRepository.save(voucher);
    }

    public void deleteVoucher(long id) {
        this.voucherRepository.deleteById(id);
    }

    public Voucher getVoucherById(long id) {
        Optional<Voucher> voucherOptional = this.voucherRepository.findById(id);
        if (voucherOptional.isPresent()) {
            return voucherOptional.get();
        }
        return null;
    }

    public List<Voucher> getVouchersWithFilters(Long categoryId, String keyword) {
        List<Voucher> allVouchers = this.getAllVouchers();

        return allVouchers.stream().filter(v -> {

            boolean matchKeyword = (keyword == null || keyword.isEmpty()) ||
                    v.getCode().toLowerCase().contains(keyword.toLowerCase());

            boolean matchCategory = true;
            if (categoryId != null) {
                if (categoryId == -1) {

                    matchCategory = v.isAll();
                } else {

                    matchCategory = v.isAll() || v.getCategories().stream().anyMatch(c -> c.getId() == categoryId);
                }
            }

            return matchKeyword && matchCategory;
        }).toList();
    }
}
