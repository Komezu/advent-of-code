const fs = require("fs");
const utils = require("../utils.js");

const DATA = fs.readFileSync("almanac_data.txt", "utf-8");
const LINES = DATA.trim().split("\n\n").map(section => section.split("\n"));

const MAPPERS = LINES.slice(1).map(mapper => mapper.slice(1).map(line => line.split(" ").map(Number)));

function runPart1() {
  const seeds = LINES[0][0].match(/\d+/g).map(Number);
  const locations = [];

  for (const seed of seeds) {
    locations.push(mapToLocation(seed));
  }

  return Math.min(...locations);
}

function runPart2() {
  const seedRanges = utils.chopArray(LINES[0][0].match(/\d+/g).map(Number), 2);
  const lowestLocs = [];

  for (const [start, length] of seedRanges) {
    let lowest = Number.POSITIVE_INFINITY;

    for (let seed = start; seed < start + length; seed++) {
      const location = mapToLocation(seed);

      if (location < lowest) { lowest = location; }
    }

    lowestLocs.push(lowest);

    console.log(`Checked range starting at ${start}, lowest is: ${lowest}`);
  }

  return Math.min(...lowestLocs);
}

function mapToLocation(seed) {
  let currNumber = seed;

  for (const mapper of MAPPERS) {
    for (const map of mapper) {
      const [dest, start, length] = map;
      const end = start + length - 1;

      if (currNumber >= start && currNumber <= end) {
        currNumber = currNumber - start + dest;
        break;
      }
    }
  }

  return currNumber;
}

console.log(`Part 1 answer: ${runPart1()}`);
console.log(`Part 2 answer: ${runPart2()}`);
