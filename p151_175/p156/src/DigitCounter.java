public class DigitCounter {
	private long limit;
	private long[] counts = new long[10];
	private long sumOfSolutions = 0;
	
	public DigitCounter(long startLimit){
		limit = startLimit;
	}
	
	public long getSum(){
		int solutionCounter = 1;
		for (long i = 0; i <= limit; i++) {
			if (i % 1000000000L == 0) {
				System.out.println(i);
			}
			String iString = String.valueOf(i); 
			for (int charIndex=0; charIndex < iString.length(); charIndex++) {
				char c = iString.charAt(charIndex);
				int digitIndex = Character.getNumericValue(c);
				if (digitIndex > 9 || digitIndex < 0) {
					System.out.println(i);
					System.out.println(c);
				}
				counts[digitIndex]++;
			}
			
			boolean isSolution = false;
			for(int digitIndex = 1; digitIndex <= 9; digitIndex++){
				if (counts[digitIndex] == i) {
					System.out.printf("%d %d digit: %d\n", solutionCounter, i, digitIndex);
					sumOfSolutions += i;
					isSolution = true;
				}
			}
			if (isSolution) {
				solutionCounter++;
			}
		}
		
		return sumOfSolutions;
	}
}
