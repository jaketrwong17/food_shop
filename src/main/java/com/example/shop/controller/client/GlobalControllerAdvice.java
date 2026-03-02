package com.example.shop.controller.client;

import com.example.shop.domain.Policy;
import com.example.shop.service.PolicyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.util.List;

@ControllerAdvice
public class GlobalControllerAdvice {

    @Autowired
    private PolicyService policyService;

    @ModelAttribute("globalPolicies")
    public List<Policy> globalPolicies() {
        return policyService.getActivePolicies();
    }
}