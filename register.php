<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "laporan_panen";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die(json_encode(array("message" => "Connection failed: " . $conn->connect_error)));
}

$data = json_decode(file_get_contents("php://input"));

if(isset($data->email) && isset($data->password)) {
    $id = random_int(1, 999);
    $email = $data->email;
    $password = password_hash($data->password, PASSWORD_DEFAULT); // Hash the password

    $sql = "INSERT INTO user_table (id, email, password) VALUES ('$id', '$email', '$password')";

    if ($conn->query($sql) === TRUE) {
        echo json_encode(array("message" => "User registered successfully"));
    } else {
        echo json_encode(array("message" => "Error: " . $sql . "<br>" . $conn->error));
    }
} else {
    echo json_encode(array("message" => "Invalid input"));
}

$conn->close();
?>
