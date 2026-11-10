import { useMemo } from 'react';
import type { TransactionEntry } from '../../types/transaction';
import { groupTransactionsByDate, computeClosingBalances, formatCurrency, formatDate } from '../BalanceOverview/balanceUtils';
import { TransactionCard } from '../TransactionCard/TransactionCard';
import styles from './TransactionsList.module.css';

type TransactionsListProps = {
  transactions: TransactionEntry[];
  onTransactionClick: (transaction: TransactionEntry) => void;
};

export function TransactionsList({
  transactions,
  onTransactionClick,
}: TransactionsListProps) {
  const grouped = useMemo(
    () => groupTransactionsByDate(transactions),
    [transactions],
  );

  const closingBalances = useMemo(
    () => computeClosingBalances(grouped),
    [grouped],
  );

  return (
    <div className={styles.list}>
      {Array.from(grouped.entries()).map(([date, group]) => (
        <div key={date} className={styles.dateGroup}>
          <div className={styles.dateHeader}>
            <span className={styles.dateLabel}>{formatDate(date)}</span>
            <span className={styles.dateTotal}>{formatCurrency(closingBalances.get(date) ?? 0)}</span>
          </div>
          <div className={styles.cards}>
            {group.map((tx) => (
              <TransactionCard
                key={tx.id}
                transaction={tx}
                onClick={onTransactionClick}
              />
            ))}
          </div>
        </div>
      ))}
    </div>
  );
}
