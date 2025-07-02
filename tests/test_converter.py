import unittest
import converter

class TestConversao(unittest.TestCase):
    def test_fahrenheit_to_celsius(self):
        self.assertEqual(converter.fahrenheit_to_celsius(32), 0)

    def test_fail_proposital(self):
        self.assertEqual(1, 2)  # <-- Vai falhar de propósito

if __name__ == '__main__':
    unittest.main()