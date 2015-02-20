


public class Agent {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		long startTime = System.currentTimeMillis();
		long limit = 80000000000L;
//		long limit = 1000000L;
		DigitCounter digitCounter = new DigitCounter(limit);
    
		System.out.println(digitCounter.getSum());
		long endTime = System.currentTimeMillis();
		double elapsedTime = (endTime - startTime)/1000.0;
		System.out.printf("Elapsed Time: %f seconds\n", elapsedTime);
	}
}
