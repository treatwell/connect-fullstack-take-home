package com.challenge.transactions.repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.challenge.transactions.domain.Transaction;
import com.challenge.transactions.domain.TransactionStatus;
import com.challenge.transactions.domain.TransactionType;

@Repository
public interface TransactionRepository extends JpaRepository<Transaction, String> {

    @Query("""
        SELECT t FROM Transaction t
        WHERE t.supplierId = :supplierId
          AND (:type IS NULL OR t.transactionType = :type)
          AND (:status IS NULL OR t.status = :status)
          AND (:fromDate IS NULL OR t.fulfilmentDate >= :fromDate)
          AND (:toDate IS NULL OR t.fulfilmentDate <= :toDate)
        ORDER BY t.fulfilmentDate DESC, t.id DESC
        """)
    List<Transaction> findTransactions(
            @Param("supplierId") Long supplierId,
            @Param("type") TransactionType type,
            @Param("status") TransactionStatus status,
            @Param("fromDate") LocalDate fromDate,
            @Param("toDate") LocalDate toDate);

    Optional<Transaction> findBySourceId(String sourceId);
}
