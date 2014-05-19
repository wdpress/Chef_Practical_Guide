listen "/tmp/unicorn.sock"
worker_processes 2 # this should be >= nr_cpus
pid "/home/vagrant/test_unicorn/shared/pids/unicorn.pid"
stderr_path "/home/vagrant/test_unicorn/shared/log/unicorn.log"
stdout_path "/home/vagrant/test_unicorn/shared/log/unicorn.log"
