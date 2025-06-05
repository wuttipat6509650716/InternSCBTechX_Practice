package com.example.demo;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class DemoController {
    private final StorageRepository repository;

    DemoController(StorageRepository repository){
        this.repository = repository;
    }

    @GetMapping("/all")
    public List<Storage> getAll() {
        return repository.findAll();
    }
}
