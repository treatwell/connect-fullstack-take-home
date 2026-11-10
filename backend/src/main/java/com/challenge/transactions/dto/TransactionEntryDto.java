package com.challenge.transactions.dto;

import java.math.BigDecimal;

import com.challenge.transactions.domain.Transaction;

public record TransactionEntryDto(
        String id,
        String type,
        String referenceId,
        String reference,
        String description,
        BigDecimal amount,
        BigDecimal netAmount,
        BigDecimal feeAmount,
        String status,
        String paymentMethod,
        String fulfilmentDate,
        boolean newCustomer
) {
    public static TransactionEntryDto from(Transaction t) {
        return new TransactionEntryDto(
                t.getId(),
                t.getTransactionType().name(),
                t.getReferenceId(),
                t.getReference(),
                t.getDescription(),
                t.getAmount(),
                t.getNetAmount(),
                t.getFeeAmount(),
                t.getStatus().name(),
                t.getPaymentMethod(),
                t.getFulfilmentDate() != null ? t.getFulfilmentDate().toString() : null,
                t.isNewCustomer()
        );
    }
}
