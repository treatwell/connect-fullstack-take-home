import type { TransactionFilter } from '../../types/transaction';
import { getBalanceFilterItems } from '../BalanceOverview/balanceUtils';
import styles from './FilterTabs.module.css';

type FilterTabsProps = {
  activeFilter: TransactionFilter;
  onFilterChange: (filter: TransactionFilter) => void;
};

export function FilterTabs({ activeFilter, onFilterChange }: FilterTabsProps) {
  const items = getBalanceFilterItems();

  return (
    <div className={styles.tabs}>
      {items.map((item) => (
        <div
          key={item.value}
          className={`${styles.tab} ${activeFilter === item.value ? styles.active : ''}`}
          onClick={() => onFilterChange(item.value)}
        >
          {item.label}
        </div>
      ))}
    </div>
  );
}
