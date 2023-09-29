package com.example.practice3.image;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.io.InputStream;
import java.util.Objects;

@Slf4j
@Controller
public class ImageController {
    @Value("${image.path}")
    private String imagePath;

    @GetMapping(value = "/image", produces = MediaType.IMAGE_PNG_VALUE)
    public @ResponseBody byte[] getImage() throws IOException {
        log.info("Try to get image = {}", imagePath);
        try(InputStream in = this.getClass().getClassLoader()
                .getResourceAsStream(imagePath)) {
            return Objects.requireNonNull(in).readAllBytes();
        }
    }
}
