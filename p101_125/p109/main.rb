miss = [[0, 0]]
singles = []
doubles = []
trebles = []

(1..20).each do |score|
  singles << [score, 1]
  doubles << [score, 2]
  trebles << [score, 3]
end

singles << [25, 1]
doubles << [25, 2]

hits = miss + singles + doubles + trebles
hit_count = hits.length

count = 0
scores = []

doubles.each do |double|
  (0..hit_count-1).each do |index1|
    hit1 = hits[index1]
    (index1..hit_count-1).each do |index2|
      hit2 = hits[index2]
      score = double[0] * double[1] + hit1[0] * hit1[1] + hit2[0] * hit2[1]
      scores << score
      count += 1 if score < 100
    end
  end
end

p count
