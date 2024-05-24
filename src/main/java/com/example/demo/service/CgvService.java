package com.example.demo.service;

import java.util.List;
import com.example.demo.vo.CgvVO;

public class CgvService {

    public static String generateImageUrls(List<CgvVO> movies) {
        StringBuilder imageUrls = new StringBuilder("[");
        for (int i = 0; i < movies.size(); i++) {
            if (i > 0) {
                imageUrls.append(", ");
            }
            imageUrls.append("\"").append(movies.get(i).getImage()).append("\"");
        }
        imageUrls.append("]");
        return imageUrls.toString();
    }
}
