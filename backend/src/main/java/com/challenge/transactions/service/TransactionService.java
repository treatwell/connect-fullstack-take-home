package com.challenge.transactions.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.stereotype.Service;

import com.challenge.transactions.domain.Transaction;
import com.challenge.transactions.domain.TransactionStatus;
import com.challenge.transactions.domain.TransactionType;
import com.challenge.transactions.dto.TransactionEntryDto;
import com.challenge.transactions.dto.TransactionListResponse;
import com.challenge.transactions.dto.WebhookEventDto;
import com.challenge.transactions.repository.TransactionRepository;

@Service
public class TransactionService {

    private final TransactionRepository repository;

    public TransactionService(TransactionRepository repository) {
        this.repository = repository;
    }

    public TransactionListResponse listTransactions(
            Long supplierId,
            TransactionType type,
            TransactionStatus status,
            LocalDate fromDate,
            LocalDate toDate) {
        List<Transaction> results = repository.findTransactions(supplierId, type, status, fromDate, toDate);
        List<TransactionEntryDto> dtos = results.stream()
                .map(TransactionEntryDto::from)
                .toList();

        return new TransactionListResponse(dtos);
    }

    public Transaction upsertFromWebhook(WebhookEventDto event) {
        TransactionType type = TransactionType.valueOf(event.transactionType());

        Transaction transaction = repository
                .findBySourceId(event.sourceId())
                .orElseGet(Transaction::new);

        transaction.setTransactionType(type);
        transaction.setSupplierId(event.supplierId());
        transaction.setSourceId(event.sourceId());
        transaction.setReferenceId(event.referenceId());
        transaction.setReference(event.reference());
        transaction.setDescription(event.description());
        transaction.setStatus(TransactionStatus.valueOf(event.status()));
        transaction.setCurrency(event.currency());
        transaction.setAmount(event.amount());
        transaction.setNetAmount(event.netAmount());
        transaction.setFeeAmount(event.feeAmount());
        transaction.setTaxAmount(event.taxAmount());
        transaction.setPaymentMethod(event.paymentMethod());
        transaction.setFulfilmentDate(event.fulfilmentDate() != null ? LocalDate.parse(event.fulfilmentDate()) : null);
        transaction.setPayAtVenue(event.payAtVenue());
        transaction.setNewCustomer(event.newCustomer());

        return repository.save(transaction);
    }
}
