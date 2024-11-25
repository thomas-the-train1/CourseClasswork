/**
 * Creates an array of scores.
 * @author - Thomas Eden
 * @version - October 25, 2022
 */

public class Scores {

   private int[] numbers;
   
   /**
    * Constructor sets numbers.
    * @param numbersIn for numbers
    */
   
   public Scores(int[] numbersIn) {
      
      numbers = numbersIn;
   
   }
   
   /**
    * Finds even values in the array.
    * @return array of even values
    */
   
   public int[] findEvens() {
      int numberEvens = 0;
      for (int i = 0; i < numbers.length; i++) {
         if (numbers[i] % 2 == 0) {
            numberEvens++;
         }
      }
         
      int[] evens = new int[numberEvens];
      int count = 0;
      for (int i = 0; i < numbers.length; i++) {
         if (numbers[i] % 2 == 0) {
            evens[count] = numbers[i];
            count++;
         }   
      }
      return evens;
   }
   
   /**
    * Finds odd values in the array.
    * @return array of odd values
    */
   
   public int[] findOdds() {
      int numberOdds = 0;
      for (int i = 0; i < numbers.length; i++) {
         if (numbers[i] % 2 != 0) {
            numberOdds++;
         }
      }
         
      int[] odds = new int[numberOdds];
      int count = 0;
      for (int i = 0; i < numbers.length; i++) {
         if (numbers[i] % 2 != 0) {
            odds[count] = numbers[i];
            count++;
         }   
      }
      return odds;
   }
   
   /**
    * Calculates average of all values in the array.
    * @return array with average values
    */
   
   public double calculateAverage() {
      int sum = 0;
      for (int i = 0; i < numbers.length; i++) {
         sum += numbers[i];
      }
      return (sum / numbers.length);
   }
   
   /**
    * String method for Scores array.
    * @return result
    */
   
   public String toString() {
      String result = "";
      for (int i = 0; i < numbers.length; i++) {
         result += numbers[i] + "\t";
      }
      return result;
   }
   
   /**
    * Reverse String method for Scores array.
    * @return result
    */
   
   public String toStringInReverse() {
      String result = "";
      for (int i = numbers.length - 1; i >= 0; i--) {
         result += numbers[i] + "\t";
      }
      return result;
   }
}