arr = {}

('a'..'z').each_with_index { |letter, index| arr[letter] = index + 1 }

print arr
