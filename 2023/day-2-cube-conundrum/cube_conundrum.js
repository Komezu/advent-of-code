const fs = require("fs");

const DATA = fs.readFileSync("cube_data.txt", "utf-8");
const LINES = DATA.trim().split("\n");

function runPart1() {
  let sum = 0;

  for (let i = 0; i < LINES.length; i++) {
    const sets = LINES[i].match(/\d+ (red|green|blue)/g);
    let isPossible = true;

    for (const set of sets) {
      let [count, color] = set.split(" ");
      count = parseInt(count);

      if (color === "red" && count > 12 || color === "green" && count > 13 || color === "blue" && count > 14) {
        isPossible = false;
        break;
      }
    }

    if (isPossible) { sum += i + 1; }
  }

  return sum;
}

function runPart2() {
  let sum = 0;

  for (const line of LINES) {
    const sets = line.match(/\d+ (red|green|blue)/g);
    let [red, green, blue] = [0, 0, 0];

    for (const set of sets) {
      let [count, color] = set.split(" ");
      count = parseInt(count);

      if (color === "red" && count > red) {
        red = count;
      } else if (color === "green" && count > green) {
        green = count;
      } else if (color === "blue" && count > blue) {
        blue = count;
      }
    }

    sum += red * green * blue;
  }

  return sum;
}

console.log(`Part 1 answer: ${runPart1()}`);
console.log(`Part 2 answer: ${runPart2()}`);
