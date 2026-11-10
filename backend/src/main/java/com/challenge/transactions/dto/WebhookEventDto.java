package com.challenge.transactions.dto;

import java.math.BigDecimal;

public record WebhookEventDto(
        String transactionType,
        Long supplierId,
        String sourceId,
        String referenceId,
        String reference,
        String description,
        String status,
        String currency,
        BigDecimal amount,
        BigDecimal netAmount,
        BigDecimal feeAmount,
        BigDecimal taxAmount,
        String paymentMethod,
        String fulfilmentDate,
        boolean payAtVenue,
        boolean newCustomer
) {}
