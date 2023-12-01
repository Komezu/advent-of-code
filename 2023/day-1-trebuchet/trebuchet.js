const fs = require("fs");

const DATA = fs.readFileSync("calibration_data.txt", "utf-8");
const LINES = DATA.trim().split("\n");

function runPart1() {
  let sum = 0;

  for (const line of LINES) {
    const digits = line.match(/\d/g);
    if (digits) { sum += parseInt(digits[0] + digits[digits.length - 1]) };
  }

  return sum;
}

function runPart2() {
  const mapper = {
    one: "1", two: "2", three: "3", four: "4", five: "5", six: "6", seven: "7", eight: "8", nine: "9"
  }

  let sum = 0;

  for (const line of LINES) {
    const first = line.match(/\d|one|two|three|four|five|six|seven|eight|nine/)[0];
    const last = line.match(/.*(\d|one|two|three|four|five|six|seven|eight|nine)/)[1];
    sum += parseInt((mapper[first] ?? first) + (mapper[last] ?? last));
  }

  return sum;
}

console.log(`Part 1 answer: ${runPart1()}`);
console.log(`Part 2 answer: ${runPart2()}`);
