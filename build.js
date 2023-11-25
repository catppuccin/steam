const fs = require("fs").promises;
const path = require("path");
const { compileString } = require("sass");

const sourceFiles = [
  "src/frappe/libraryroot.custom-frappe.scss",
  "src/latte/libraryroot.custom-latte.scss",
  "src/macchiato/libraryroot.custom-macchiato.scss",
  "src/mocha/libraryroot.custom-mocha.scss",

  "src/frappe/friends.custom-frappe.scss",
  "src/latte/friends.custom-latte.scss",
  "src/macchiato/friends.custom-macchiato.scss",
  "src/mocha/friends.custom-mocha.scss",
];

const accents = [
  "rosewater",
  "flamingo",
  "pink",
  "mauve",
  "red",
  "maroon",
  "peach",
  "yellow",
  "green",
  "teal",
  "sky",
  "sapphire",
  "blue",
  "lavender",
];

(async () => {
  await Promise.all(sourceFiles.map(generateAccents));
  console.log("Generated all accents for all flavours");
})();

// read sourceFile and generate all accents for it
async function generateAccents(sourceFilePath) {
  const _sourceFilePath = path.join(__dirname, sourceFilePath);
  const sourceFileData = await fs.readFile(_sourceFilePath, {
    encoding: "utf8",
  });
  return Promise.all(
    accents.map((accent) =>
      generateAccent(sourceFileData, sourceFilePath, accent)
    )
  );
}

// replace accent and write to a separate file in a subfolder
async function generateAccent(sourceFileData, sourceFilePath, accent) {
  const modifiedFileContent = sourceFileData.replace(
    /\$accent: .*;/gm,
    `$accent: \$${accent};`
  );

  // Create a subfolder for each accent
  const outputDirName = sourceFilePath.replace(/\/[^/]+$/, `/${accent}`);
  await fs.mkdir(outputDirName, { recursive: true });

  const outputFileName = path.basename(sourceFilePath.replace(/-(mocha|macchiato|latte|frappe)(\.scss)$/, '$2'));
  const outputFilePath = path.join(outputDirName, outputFileName);
  await fs.writeFile(outputFilePath, modifiedFileContent);
  console.log(`Generated: ${outputFilePath}`);
}
