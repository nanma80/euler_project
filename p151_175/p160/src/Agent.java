import java.math.BigInteger;

public class Agent {
	public static long factorialLastDigits(long n, long mod) {
		long power2minus5 = 0;
		
		long otherLastDigits = 1;
		long startTime = System.currentTimeMillis();
		long displayStep = 1000000000L;
		for (long originalK = 2; originalK <= n; originalK++) {
			if (originalK % 1000000000L == 0) {
				long endTime = System.currentTimeMillis();
				System.out.format("%d billion; time: %f\n", (int)(originalK / displayStep), (endTime - startTime)/1000.0);
				startTime = endTime;
			}
			
			long k = originalK;
			if (k % 2 == 0) {
				power2minus5 ++;
				k = k / 2;
			}
			
			while (k % 5 == 0) {
				power2minus5 --;
				k = k / 5;
			}

			otherLastDigits = (otherLastDigits * k) % mod;
		}
		
		BigInteger base = new BigInteger("2");
		BigInteger exponent = new BigInteger(String.valueOf(power2minus5));
		BigInteger modBigInt = new BigInteger(String.valueOf(mod));
		BigInteger modPower = base.modPow(exponent, modBigInt);
		
		long factor2 = modPower.longValue();
		
		return (otherLastDigits * factor2) % mod;
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		long startTime = System.currentTimeMillis();
		long limit = 1000000000000L;
		long lastDigits = factorialLastDigits(limit, 100000L);
		System.out.println(lastDigits);
		long endTime = System.currentTimeMillis();
		double elapsedTime = (endTime - startTime)/1000.0;
		System.out.printf("Elapsed Time: %f seconds\n", elapsedTime);
	}
}
