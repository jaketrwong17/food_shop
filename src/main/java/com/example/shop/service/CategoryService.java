package com.example.shop.service;

import com.example.shop.domain.Category;
import com.example.shop.repository.CategoryRepository;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class CategoryService {
    private final CategoryRepository categoryRepository;

    public CategoryService(CategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }

    public List<Category> getAllCategories(String keyword) {
        if (keyword != null && !keyword.isEmpty()) {
            return categoryRepository.findByNameContainingIgnoreCase(keyword);
        }
        return categoryRepository.findAll();
    }

    public Category getCategoryById(long id) {
        return categoryRepository.findById(id).orElse(null);
    }

    public void saveCategory(Category category) {
        categoryRepository.save(category);
    }

    public void deleteCategory(long id) {
        categoryRepository.deleteById(id);
    }
}