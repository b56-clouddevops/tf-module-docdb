resource "null_resource" "schema" {

    # This make sures that this null_resource will only be executed post the creation of the RDS only    
    depends_on = [aws_db_instance.docdb, aws_docdb_cluster_instance.cluster_instances]

      provisioner "local-exec" {
        command = <<EOF
            cd /tmp
            wget https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem
            curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"
            unzip -o mongodb.zip
            cd mongodb-main
            ls -ltr
            mongo --ssl --host ${aws_db_instance.docdb.endpoint}:27017 --sslCAFile /tmp/global-bundle.pem --username admin1 --password RoboShop1 < catalogue.js
            mongo --ssl --host ${aws_db_instance.docdb.endpoint}:27017 --sslCAFile /tmp/global-bundle.pem --username admin1 --password RoboShop1 < users.js
        EOF
    }
}
