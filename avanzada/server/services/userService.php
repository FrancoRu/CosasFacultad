 <?php
  require_once 'DBServices.php';

  class UserService
  {
    private static $instance;
    private $dbInstance;

    private function __construct()
    {
      $this->dbInstance = DBServices::getInstance();
    }

    public static function getInstance()
    {
      if (self::$instance === null) {
        self::$instance = new self();
      }
      return self::$instance;
    }

    public function logIn($args)
    {
      try {
        $result = $this->dbInstance->executeQuery($_ENV['QUERY_LOGIN'], [$args['username']]);
        if ($result->num_rows > 0) {
          $row = $result->fetch_assoc();
          return password_verify($args['password'], $row['password']);
        } else {
          return null;
        }
      } catch (Exception $e) {
        return $e->getMessage(); // Maneja la excepción de manera adecuada
      }
    }
    public function signUp($args)
    {
      try {
        $result = $this->dbInstance->executeQuery($_ENV['QUERY_LOGIN'], [$args['username']]);
        if ($result->num_rows > 0) {
          return false;
        } else {
          $passwordHash = password_hash($args['password'], PASSWORD_BCRYPT);
          $result = $this->dbInstance->executeQuery($_ENV['QUERY_REGISTER'], [$args['username'], $passwordHash]);
          if ($result) {
            return true;
          }
        }
        return false;
      } catch (Exception $e) {
        return $e->getMessage(); // Maneja la excepción de manera adecuada
      }
    }

    public function changePassword($args)
    {
      try {
        if ($this->login($args)) {
          $passwordHash = password_hash($args['new-password'], PASSWORD_BCRYPT);
          $result = $this->dbInstance->executeQuery($_ENV['QUERY_MODIFY_PASSWORD'], [$args['username'], $passwordHash]);
          if ($result->num_rows > 0) {
            return true;
          } else {
            return null;
          }
        }
      } catch (Exception $e) {
        return $e->getMessage(); // Maneja la excepción de manera adecuada
      }
    }
  }
