# Validation Checklist

- [ ] System boots cleanly, `systemctl --failed` shows no failures
- [ ] Users cannot bypass sudo restrictions
- [ ] Logs are generated and readable in `/var/log/company`
- [ ] Scripts run idempotently without errors
- [ ] Network connectivity verified (ping, curl, wget)
- [ ] Permissions enforce role-based access

## Sample Checks

```bash
systemctl status nginx
journalctl -u ssh --since today
./backup.sh --dry-run
```
