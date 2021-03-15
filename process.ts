var fs = require("fs");
const fsPromises = require("fs").promises;
const readline = require("readline");
const ipv4 = require("node-ipv4");

const folder = "./blocklist-ipsets/";

import { RDS_HOST, USER, PASS } from "./config";

var mysql = require("mysql2/promise");

const pool = mysql.createPool({
  host: RDS_HOST,
  user: USER,
  password: PASS,
  database: "ip_project",
  waitForConnections: true,
  connectionLimit: 100,
  queueLimit: 0,
});

async function processFiles(): Promise<boolean> {
  //

  const filenames = await fsPromises.readdir(folder);
  console.log(`processFiles - Files = ${JSON.stringify(filenames)}`);

  for (let filename of filenames) {
    console.log(`processFiles - filename = ${filename}`);
    if (filename.endsWith(".ipset") || filename.endsWith(".netset")) {
      await processLineByLine(filename);
    }
  }

  return Promise.resolve(true);
}

async function processLineByLine(filename: string): Promise<boolean> {
  const fileStream = fs.createReadStream(folder + filename);

  const rl = readline.createInterface({
    input: fileStream,
    crlfDelay: Infinity,
  });

  var networks = [];
  var addresses = [];

  for await (const line of rl) {
    if (line.indexOf("#") !== 0) {
      if (line.indexOf("/") > -1) {
        // console.log(`Network: ${line} ${filename}`);

        var cidr = line.split("/");
        ipv4.parse(cidr[0], parseInt(cidr[1]), (err, subnet) => {
          if (err) return console.error(err);
          networks.push([
            line,
            subnet.first.value,
            subnet.last.value,
            filename,
          ]);
        });
      } else {
        // console.log(`Address: ${line} ${filename}`);
        addresses.push([line, filename]);
      }
    }
  }

  if (networks && networks.length) {
    // handle network
    var sql =
      "INSERT INTO networks_tmp (cidr, nw_start, nw_end, name) VALUES ?";

    await pool.query(sql, [networks], function (err: any) {
      if (err) throw err;
    });
  }

  if (addresses && addresses.length) {
    // handle address
    var sql = "INSERT INTO addresses_tmp (address, name) VALUES ?";
    await pool.query(sql, [addresses], function (err: any) {
      if (err) throw err;
    });
  }

  return Promise.resolve(true);
}

async function go() {
  console.log("Main Async - Process file finished");
  await processFiles();
  console.log("Main Async - Process file finished");
  process.exit();
}

console.log("Main - Starting");
go();
