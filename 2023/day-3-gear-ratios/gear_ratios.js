const fs = require("fs");
const utils = require("../utils.js");

const DATA = fs.readFileSync("engine_data.txt", "utf-8");
const LINES = utils.padInputOnAllSides(DATA.trim().split("\n"), ".");

function runPart1() {
  let sum = 0;

  for (let i = 0; i < LINES.length; i++) {
    const numbers = LINES[i].matchAll(/\d+/g);

    for (const number of numbers) {
      const start = number.index - 1;
      const end = number.index + number[0].length;

      for (let j = start; j <= end; j++) {
        if (isSymbol(LINES[i - 1][j]) || isSymbol(LINES[i][j]) || isSymbol(LINES[i + 1][j])) {
          sum += parseInt(number[0]);
          break;
        }
      }
    }
  }

  return sum;
}

function runPart2() {
  let sum = 0;

  for (let i = 0; i < LINES.length; i++) {
    const gears = LINES[i].matchAll(/\*/g);

    for (const gear of gears) {
      const index = gear.index;
      const prevLineNumbers = findAdjacentMatches(LINES[i - 1].matchAll(/\d+/g), index);
      const currLineNumbers = findAdjacentMatches(LINES[i].matchAll(/\d+/g), index);
      const nextLineNumbers = findAdjacentMatches(LINES[i + 1].matchAll(/\d+/g), index);

      if (prevLineNumbers.length + currLineNumbers.length + nextLineNumbers.length === 2) {
        const numbers = [...prevLineNumbers, ...currLineNumbers, ...nextLineNumbers];
        sum += parseInt(numbers[0]) * parseInt(numbers[1]);
      }
    }
  }

  return sum;
}

function isSymbol(char) {
  return /(\d|\.)/.test(char) ? false : true;
}

function findAdjacentMatches(matches, index) {
  const results = [];

  for (const match of matches) {
    const start = match.index - 1;
    const end = match.index + match[0].length;

    if (index >= start && index <= end) {
      results.push(match[0]);
    }
  }

  return results;
}

console.log(`Part 1 answer: ${runPart1()}`);
console.log(`Part 2 answer: ${runPart2()}`);
