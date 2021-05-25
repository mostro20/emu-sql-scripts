<?php

// PLZ no paste actual credentials here if this will be run anywhere other than your laptop
// mysqli($servername, $username, $password, $dbname);
$conn = new mysqli('127.0.0.1', 'root', 'rootroot', '20210504_LOAD_XML');

// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

importXML($conn, 'Objects_xmldata_210407.xml');
importXML($conn, 'Rights_xmldata_210407.xml');
importXML($conn, 'Parties_xmldata_210407.xml');

$conn->close();

function importXML($conn, $filename) {
  $num_errors = 0;
  echo "Importing {$filename}\n";
  libxml_use_internal_errors(TRUE);
  $data = new SimpleXmlIterator($filename, 0, TRUE);
  $tablename = $conn->real_escape_string($data->attributes()['name']);
  echo "Table: {$tablename}\n-------------------\n\n";
  $count = 1;
  $total = $data->count();
  echo "{$count} / {$total}";
  for ($data->rewind(); $data->valid(); $data->next()) {
    $cols = [];
    $values = [];
    if ($data->haschildren()) {
      foreach ($data->current()->children() as $child) {
        $cols[] = $conn->real_escape_string($child->attributes()['name']);
        $values[] = $conn->real_escape_string($child);
      }
    }
    $query = 'INSERT INTO `' . $tablename . '` (`' . implode('`, `', $cols) . '`) VALUES (\'' . implode('\',\'', $values) . '\');';
    //    mb_convert_encoding($query, <To Encoding>,<From Encoding>);
    //    $query = mb_convert_encoding($query, 'UTF-8','ISO-8859-1');

    if ($conn->query($query) !== TRUE) {
      $num_errors++;
      log_error("Error: " . $conn->error . "\n" . print_r($query, 1), $tablename);
    }
    show_status($filename, $count++, $total, $num_errors);
  }
  echo "\n";

  echo "\n-------------------\n\n";
}

function log_error($msg, $tablename) {
  static $timestamp;
  if (!$timestamp) {
    $timestamp = gmdate("Ymdhis");
  }
  $path = 'logs';
  if (!is_dir($path)) {
    mkdir($path);
  }
  $path .= '/'. $timestamp;
  if (!is_dir($path)) {
    mkdir($path);
  }
  $path .= '/import_errors-' . $timestamp . '-' . $tablename .'.log';
  file_put_contents($path, $msg."\n------\n", FILE_APPEND);
}


/*

Copyright (c) 2010, dealnews.com, Inc.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice,
   this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.
 * Neither the name of dealnews.com, Inc. nor the names of its contributors
   may be used to endorse or promote products derived from this software
   without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.

 */

/**
 * show a status bar in the console
 *
 * <code>
 * for($x=1;$x<=100;$x++){
 *
 *     show_status($x, 100);
 *
 *     usleep(100000);
 *
 * }
 * </code>
 *
 * @param int $done how many items are completed
 * @param int $total how many items are to be done total
 *
 * @return  void
 *
 */

function show_status($title, $done, $total, $num_errors=0) {

  static $start_time;
  $size = 30;

  // if we go over our bound, just ignore it
  if ($done > $total) {
    return;
  }

  if (empty($start_time)) {
    $start_time = time();
  }
  $now = time();

  $perc = (double) ($done / $total);

  $bar = floor($perc * $size);

  $status_bar = "\r{$title}  [";
  $status_bar .= str_repeat("=", $bar);
  if ($bar < $size) {
    $status_bar .= ">";
    $status_bar .= str_repeat(" ", $size - $bar);
  }
  else {
    $status_bar .= "=";
  }

  $disp = number_format($perc * 100, 0);

  $status_bar .= "] $disp%  $done/$total";

  $rate = ($now - $start_time) / $done;
  $left = $total - $done;
  $eta = round($rate * $left, 2);

  $elapsed = $now - $start_time;

  $status_bar .= " remaining: " . number_format($eta) . " sec.  elapsed: " . number_format($elapsed) . " sec.";

  if ($num_errors) {
    $status_bar .= " errors: " . number_format($num_errors);
  }

  echo "$status_bar  ";

  flush();

  // when done, send a newline
  if ($done == $total) {
    echo "\n";
  }

}

