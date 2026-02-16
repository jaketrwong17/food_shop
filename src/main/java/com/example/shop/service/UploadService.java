package com.example.shop.service;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;
import java.nio.file.*;
import java.util.UUID;

@Service
public class UploadService {
    public String handleSaveUploadFile(MultipartFile file, String targetFolder) {
        if (file.isEmpty())
            return null;
        try {
            String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
            String rootPath = System.getProperty("user.dir");

            Path pathTarget = Paths.get(rootPath, "target", "classes", "static", targetFolder, fileName);
            if (!Files.exists(pathTarget.getParent()))
                Files.createDirectories(pathTarget.getParent());
            Files.copy(file.getInputStream(), pathTarget, StandardCopyOption.REPLACE_EXISTING);

            Path pathSrc = Paths.get(rootPath, "src", "main", "resources", "static", targetFolder, fileName);
            if (!Files.exists(pathSrc.getParent()))
                Files.createDirectories(pathSrc.getParent());
            Files.copy(pathTarget, pathSrc, StandardCopyOption.REPLACE_EXISTING);

            return fileName;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
}