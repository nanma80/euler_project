
public class Main {

	public static long count(int n) {
		long count = 0L;
		long power10 = 1L;
		for (int nIndex = 0; nIndex < n; nIndex++) {
			power10 *= 10L;
		}
		for (long a = 1L; a <= 2 * power10; a++) {
			for (long p = power10/a + 1; p <= 2 * power10 / a; p++) {
				long bDenominator = a * p - power10;
				if ((a * power10) % bDenominator == 0) {
					count ++;
				}
			}
		}
		return count;
	}
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		long total = 0L;
		for(int n = 1; n <= 9; n++) {
			long count = count(n);
			System.out.printf("%d\t%d\n", n, count);
			total += count;
		}
		System.out.println(total);
	}
}
