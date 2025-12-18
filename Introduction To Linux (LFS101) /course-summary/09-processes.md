
# 09. Processes

## Learning Objectives

* Explain what a process is and how the kernel manages processes.
* Use process control tools to monitor and manage running programs.

## Key Concepts Explained

* **Process Model**

  * PID, PPID, process states (running, sleeping, zombie), sessions, and process groups.
  * Why it matters: resource management, service supervision, and troubleshooting.

* **Process Metrics & Control**

  * CPU, memory usage, nice/renice, signals (SIGTERM, SIGKILL), job control (fg/bg), and `systemd` unit control.

## Commands & Examples

```bash
# List processes (detailed)
ps aux --sort=-%cpu | head

# Interactive view
top
# or
htop

# Kill a process politely
kill -SIGTERM <pid>

# Change priority
sudo renice -n 10 -p <pid>
```

## Real-World Usage Scenarios

* Detecting runaway processes that consume CPU and restarting the service.
* Using `systemctl` to restart a service managed by systemd instead of killing individual PIDs.

## Common Mistakes & Best Practices

* Mistake: Sending SIGKILL immediately — lose opportunity for graceful shutdown.
* Best practice: Use logs, process parents, and systemd service management for controlled restarts.

## Diagrams & Assets

3. Process Lifecycle

```
![Process Lifecycle](../assets/summary/09-process-lifecycle.png)
```

Description: Fork → Exec → Running → Waiting → Termination.

## Summary

Processes are the active units of computation. Understanding how to monitor and control them is essential for system reliability.


# Document End
