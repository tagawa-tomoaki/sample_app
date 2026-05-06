# frozen_string_literal: true

require 'benchmark'

# Hash のキー種別（Integer / String / Symbol）による速度差をざっくり比較するベンチマーク。
# 目的：同じ条件（同じ1要素Hash、同じキーオブジェクト）で
# - 既存キーの読み取り
# - 既存キーの書き込み
# - 存在しないキーの読み取り
# を比較する。

N = ENV.fetch('N', '10_000_000').to_i

int_key = 12_345
str_key = '12345'
sym_key = :k12345

int_missing = 54_321
str_missing = '54321'
sym_missing = :k54321

int_hash = { int_key => 1 }
str_hash = { str_key => 1 }
sym_hash = { sym_key => 1 }

puts "Ruby: #{RUBY_DESCRIPTION}"
puts "N: #{N}"

Benchmark.bmbm do |x|
  x.report('read  (Integer)') { N.times { int_hash[int_key] } }
  x.report('read  (String)')  { N.times { str_hash[str_key] } }
  x.report('read  (Symbol)')  { N.times { sym_hash[sym_key] } }

  x.report('write (Integer)') { N.times { int_hash[int_key] = 2 } }
  x.report('write (String)')  { N.times { str_hash[str_key] = 2 } }
  x.report('write (Symbol)')  { N.times { sym_hash[sym_key] = 2 } }

  x.report('miss  (Integer)') { N.times { int_hash[int_missing] } }
  x.report('miss  (String)')  { N.times { str_hash[str_missing] } }
  x.report('miss  (Symbol)')  { N.times { sym_hash[sym_missing] } }
end
