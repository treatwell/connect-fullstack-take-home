package com.challenge.transactions.controller;

import java.net.URI;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.challenge.transactions.domain.Transaction;
import com.challenge.transactions.dto.WebhookEventDto;
import com.challenge.transactions.service.TransactionService;

@RestController
@RequestMapping("/api/webhooks/transactions")
public class WebhookController {

    private final TransactionService transactionService;

    public WebhookController(TransactionService transactionService) {
        this.transactionService = transactionService;
    }

    @PostMapping
    public ResponseEntity<Void> handleWebhook(@RequestBody WebhookEventDto event) {
        Transaction transaction = transactionService.upsertFromWebhook(event);
        return ResponseEntity.created(URI.create("/api/suppliers/" + transaction.getSupplierId() + "/transactions")).build();
    }
}
