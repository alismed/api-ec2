package com.alismed.deploy;

import org.springframework.http.ResponseEntity;

import java.time.Instant;

public record TimestampResponse(Instant requestDateTime) {

}
