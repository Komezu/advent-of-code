const fs = require("fs");
const utils = require("../utils.js");

const DATA = fs.readFileSync("scratchcard_data.txt", "utf-8");
const LINES = DATA.trim().split("\n");

function runPart1() {
  let sum = 0;

  for (const line of LINES) {
    const [winning, mine] = parseScratchcard(line);
    const winCount = utils.findIntersectionOfArrays(winning, mine).length;

    if (winCount > 0) { sum += Math.pow(2, winCount - 1); }
  }

  return sum;
}

function runPart2() {
  const cards = {};

  for (let i = 0; i < LINES.length; i++) {
    const cardNo = i + 1;
    const [winning, mine] = parseScratchcard(LINES[i]);
    const winCount = utils.findIntersectionOfArrays(winning, mine).length;

    cards[cardNo] ? cards[cardNo] += 1 : cards[cardNo] = 1;
    const currCardCount = cards[cardNo];

    for (let j = 1; j <= winCount; j++) {
      cards[cardNo + j] ? cards[cardNo + j] += currCardCount : cards[cardNo + j] = currCardCount;
    }
  }

  return utils.getArraySum(Object.values(cards));
}

function parseScratchcard(card) {
  return card.split(": ")[1].split(" | ").map(numStr => numStr.match(/\d+/g).map(Number));
}

console.log(`Part 1 answer: ${runPart1()}`);
console.log(`Part 2 answer: ${runPart2()}`);
