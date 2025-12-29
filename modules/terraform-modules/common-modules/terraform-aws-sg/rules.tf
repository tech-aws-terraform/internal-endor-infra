variable "rules" {
  description = "Map of known security group rules (define as 'name' = ['from port', 'to port', 'protocol', 'description'])"
  type        = map(list(any))


  default = {
    # HTTP
    http-80-tcp   = [80, 80, "tcp", "HTTP"]
    http-8081-tcp = [8081, 8081, "tcp", "HTTP"]
    http-8082-tcp = [8082, 8082, "tcp", "HTTP"]
    http-8080-tcp = [8080, 8080, "tcp", "HTTP"]
    http-5000-tcp   = [5000, 5000, "tcp", "HTTP"] 
    http-8083-tcp = [8083, 8083, "tcp", "HTTP"]    
    http-8085-tcp = [8085, 8085, "tcp", "HTTP"]
    http-8090-tcp = [8090, 8090, "tcp", "HTTP"]
    http-8095-tcp = [8095, 8095, "tcp", "HTTP"]  
    
    # HTTPS
    https-443-tcp  = [443, 443, "tcp", "HTTPS"]
    https-8443-tcp = [8443, 8443, "tcp", "HTTPS"]
    https-8081-tcp = [8081, 8081, "tcp", "HTTPS"]
    https-8082-tcp = [8082, 8082, "tcp", "HTTPS"]
    
    # PostgreSQL
    postgresql-tcp = [5432, 5432, "tcp", "PostgreSQL"]
    # MYSQL/Aurora
    mysql-tcp = [3306, 3306, "tcp", "MYSQL/Aurora"]
    # Fsx
    fsx-tcp = [988, 988, "tcp", "FSX"]  
    # Squid Proxy
    squid-tcp = [3128, 3128, "tcp", "Squid Proxy"]      
    # SSH
    ssh-tcp = [22, 22, "tcp", "SSH"]
    # RDP
    rdp-tcp = [3389, 3389, "tcp", "RDP"]
    # MSK Kafka access
    kafka-9200-tcp = [9200, 9200, "tcp", "MSK Kafka access"]
    # MSK Kafka access
    kafka-9300-tcp = [9300, 9300, "tcp", "MSK Kafka access"]
    # Redis-cache
    redis-tcp = [6379, 6379, "tcp", "redis"]
    # Open all ports & protocols
    all-all       = [-1, -1, "-1", "All protocols"]
    all-tcp       = [0, 65535, "tcp", "All TCP ports"]

  }
}


