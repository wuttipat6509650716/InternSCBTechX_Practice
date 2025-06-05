package com.example.demo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class LoadDatabase {

    public static final Logger log = LoggerFactory.getLogger(LoadDatabase.class);

    @Bean
    CommandLineRunner initDatabase(StorageRepository repository){
        return args -> {
            log.info("loading storage " + repository.save(new Storage("Docker")));
            log.info("loading storage " + repository.save(new Storage("Azure")));
            log.info("loading storage " + repository.save(new Storage("AWS")));
            log.info("loading storage " + repository.save(new Storage("Terraform")));
            log.info("loading storage " + repository.save(new Storage("Kubernetes")));
            log.info("loading storage " + repository.save(new Storage("Jenkins")));        
        };
    }
    
}
