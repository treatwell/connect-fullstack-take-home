import { useState, useMemo, useCallback } from 'react';
import type { TransactionEntry, TransactionFilter } from '../../types/transaction';
import { useTransactions } from '../../hooks/useTransactions';
import { FilterTabs } from '../FilterTabs/FilterTabs';
import { TransactionsList } from '../TransactionsList/TransactionsList';
import { TransactionDetails } from '../TransactionDetails/TransactionDetails';
import styles from './BalanceOverview.module.css';

type BalanceOverviewProps = {
  supplierId: number;
};

export function BalanceOverview({ supplierId }: BalanceOverviewProps) {
  const [filter, setFilter] = useState<TransactionFilter>('all');
  const [selectedTransaction, setSelectedTransaction] = useState<TransactionEntry | null>(null);

  const { data, isLoading } = useTransactions(supplierId, filter);

  const transactions = useMemo(
    () => data?.transactions ?? [],
    [data],
  );

  const handleTransactionClick = useCallback((tx: TransactionEntry) => {
    setSelectedTransaction(tx);
  }, []);

  const handleCloseDetails = useCallback(() => {
    setSelectedTransaction(null);
  }, []);

  return (
    <div className={styles.container}>
      <div className={styles.heading}>Balance Overview</div>

      <FilterTabs activeFilter={filter} onFilterChange={setFilter} />

      {isLoading && (
        <div className={styles.state}>Loading transactions...</div>
      )}

      {!isLoading && (
        <TransactionsList
          transactions={transactions}
          onTransactionClick={handleTransactionClick}
        />
      )}

      {selectedTransaction && (
        <TransactionDetails
          transaction={selectedTransaction}
          onClose={handleCloseDetails}
        />
      )}
    </div>
  );
}
