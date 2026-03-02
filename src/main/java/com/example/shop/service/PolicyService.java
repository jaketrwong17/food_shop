package com.example.shop.service;

import com.example.shop.domain.Policy;
import com.example.shop.repository.PolicyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PolicyService {

    @Autowired
    private PolicyRepository policyRepository;

    // Lấy tất cả chính sách
    public List<Policy> getAllPolicies() {
        return policyRepository.findAll();
    }

    // Lấy chính sách theo ID
    public Policy getPolicyById(Long id) {
        Optional<Policy> policy = policyRepository.findById(id);
        return policy.orElse(null);
    }

    // Lưu mới hoặc Cập nhật (nếu đã có ID)
    public Policy savePolicy(Policy policy) {
        return policyRepository.save(policy);
    }

    // Xóa chính sách
    public void deletePolicy(Long id) {
        policyRepository.deleteById(id);
    }

    // Đổi trạng thái Ẩn/Hiện
    public void toggleStatus(Long id) {
        Policy policy = getPolicyById(id);
        if (policy != null) {
            policy.setActive(!policy.isActive());
            policyRepository.save(policy);
        }
    }

    // Thêm hàm này vào dưới cùng của PolicyService
    public List<Policy> getActivePolicies() {
        return policyRepository.findByActiveTrue();
    }
}