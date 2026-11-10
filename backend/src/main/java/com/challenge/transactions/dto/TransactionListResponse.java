package com.challenge.transactions.dto;

import java.util.List;

public record TransactionListResponse(
        List<TransactionEntryDto> transactions
) {}
