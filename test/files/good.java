/**
 * Typical hello world example.
 */
final class HelloWorld {
  /**
   * Prevent class from being instantiated.
   *
   * @throws AssertionError
   */
  private HelloWorld() {
    throw new AssertionError("Instantiating utility class...");
  }

  /**
   * Prints Hello World!
   *
   * @param args Command line arguments
   */
  public static void main(final String[] args) {
    System.out.println("Hello World!");
  }
}
