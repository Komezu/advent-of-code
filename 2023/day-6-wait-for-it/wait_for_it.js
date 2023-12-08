const fs = require("fs");
const utils = require("../utils.js");

const DATA = fs.readFileSync("race_data.txt", "utf-8");
const LINES = DATA.trim().split("\n");

function runPart1() {
  const times = LINES[0].match(/\d+/g).map(Number);
  const distances = LINES[1].match(/\d+/g).map(Number);
  const counts = [];

  for (let i = 0; i < times.length; i++) {
    let count = 0;

    for (let j = 1; j < times[i]; j++) {
      if ((times[i] - j) * j > distances[i]) { count += 1; }
    }

    counts.push(count);
  }

  return utils.getArrayProduct(counts);
}

function runPart2() {
  const time = parseInt(LINES[0].match(/\d+/g).join(""));
  const distance = parseInt(LINES[1].match(/\d+/g).join(""));
  let count = 0;

  for (let i = 1; i < time; i++) {
    if ((time - i) * i > distance) { count += 1; }
  }

  return count;
}

console.log(`Part 1 answer: ${runPart1()}`);
console.log(`Part 2 answer: ${runPart2()}`);
