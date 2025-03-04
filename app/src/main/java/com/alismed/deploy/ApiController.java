package com.alismed.deploy;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;

@RestController
public class ApiController {

    @GetMapping
    public ResponseEntity<TimestampResponse> helloaws() {
        return ResponseEntity.ok(new TimestampResponse(Instant.now()));
    }
}
