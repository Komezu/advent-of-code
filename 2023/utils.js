function getArraySum(array, initialValue = 0) {
  return array.reduce((a, b) => a + b, initialValue);
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
  padInputOnAllSides
}
