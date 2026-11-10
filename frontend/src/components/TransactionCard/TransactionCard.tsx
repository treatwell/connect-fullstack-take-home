import type { TransactionEntry } from '../../types/transaction';
import { formatCurrency } from '../BalanceOverview/balanceUtils';
import { getTransactionDisplay, getStatusLabel, getStatusClass } from './transactionCardUtils';
import styles from './TransactionCard.module.css';

type TransactionCardProps = {
  transaction: TransactionEntry;
  onClick: (transaction: TransactionEntry) => void;
};

export function TransactionCard({ transaction, onClick }: TransactionCardProps) {
  const display = getTransactionDisplay(transaction.type, transaction.status);
  const statusClass = getStatusClass(transaction.status);
  const isNegative = transaction.amount < 0;

  return (
    <div className={styles.card} onClick={() => onClick(transaction)}>
      <div className={styles.icon}>{display.icon}</div>
      <div className={styles.content}>
        <div className={styles.label}>{display.label}</div>
        <div className={styles.detail}>
          {transaction.reference || transaction.description}
        </div>
      </div>
      <div className={styles.right}>
        <div className={`${styles.amount} ${isNegative ? styles.negative : ''}`}>
          {formatCurrency(transaction.amount)}
        </div>
        <span className={`${styles.badge} ${styles[statusClass]}`}>
          {getStatusLabel(transaction.status)}
        </span>
      </div>
    </div>
  );
}
