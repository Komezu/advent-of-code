function getArraySum(array, initialValue = 0) {
  return array.reduce((a, b) => a + b, initialValue);
}

function getArrayProduct(array, initialValue = 1) {
  return array.reduce((a, b) => a * b, initialValue);
}

function findIntersectionOfArrays(arrA, arrB) {
  return arrA.filter((elem) => arrB.includes(elem));
}

function chopArray(array, chunkSize) {
  const arrayChunks = [];

  while (array.length >= chunkSize) {
    const chunk = array.splice(0, chunkSize);
    arrayChunks.push(chunk);
  }

  if (array.length > 0) { arrayChunks.push(array); }

  return arrayChunks;
}

function mergeSortedRanges(ranges) {
  const mergedRanges = [];
  let currRange = ranges[0];

  for (const range of ranges.slice(1)) {
    if (currRange[1] < range[0] - 1) {
      mergedRanges.push(currRange);
      currRange = range;
    } else {
      currRange = [currRange[0], Math.max(currRange[1], range[1])];
    }
  }

  mergedRanges.push(currRange);

  return mergedRanges;
}

function padInputOnAllSides(inputLines, paddingChar) {
  if (paddingChar.length !== 1) {
    throw new Error(`Invalid padding character length of: ${paddingChar.length}`);
  }

  return [
    paddingChar.repeat(inputLines[0].length + 2),
    ...inputLines.map(line => paddingChar + line + paddingChar),
    paddingChar.repeat(inputLines[0].length + 2)
  ]
}

module.exports = {
  getArraySum,
  getArrayProduct,
  findIntersectionOfArrays,
  chopArray,
  mergeSortedRanges,
  padInputOnAllSides
}
