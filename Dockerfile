FROM cassandra:3

RUN apt-get -y update && apt-get install -y sudo
RUN	mkdir -p /tmp/ramdisk && \
	mkdir -p /tmp/ramdisk/hints && \
	mkdir -p /tmp/ramdisk/commit && \
	mkdir -p /tmp/ramdisk/data && \
	mkdir -p /tmp/ramdisk/saved_caches
RUN sudo chown -R cassandra:cassandra /tmp/ramdisk/hints
RUN	sudo chown -R cassandra:cassandra /tmp/ramdisk/commit
RUN	sudo chown -R cassandra:cassandra /tmp/ramdisk/data
RUN	sudo chown -R cassandra:cassandra /tmp/ramdisk/saved_caches
RUN	echo "hints_directory: /tmp/ramdisk/hints " >> /etc/cassandra/cassandra.yaml && \
	echo "data_file_directories:" >> /etc/cassandra/cassandra.yaml && \
	echo "    - /tmp/ramdisk/data" >> /etc/cassandra/cassandra.yaml && \
	echo "commitlog_directory: /tmp/ramdisk/commit" >> /etc/cassandra/cassandra.yaml && \
	echo "saved_caches_directory: /tmp/ramdisk/saved_caches"  >> /etc/cassandra/cassandra.yaml

COPY mount_and_restart.sh /mount_and_restart.sh
RUN chmod +x /mount_and_restart.sh

CMD ["bash", "./mount_and_restart.sh"]
