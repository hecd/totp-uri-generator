This script helps permanent storage of TOTP seeds while (possibly) reducing the attack vector if used on airgapped systems.
The TOTP seed is typically generated on an Internet connected system and transferred manually to the database by typing it into the airgapped system for permanent storage.

Clients supporting QR scanning (such as Google Authenticator, FreeOTP) can import the OTP URI by simply scanning the generated QR image.Depending on threat model, a hardware token such as Yubikey could be used by loading it with the seed value (from Internet connected system or airgap).

Database format (permanent storage of seeds) is a new-line separated file where each line consists of a semicolon separated entry of:
<TOTP label, typically displayed in the client application>;<TOTP seed>

Arguments:
--database=PATH
  path to database to be used, default value of ./seed.db

--line=LINE
  what line in the database to generate TOTP URI for, default 1

--qr
  whether generated TOTP URI should be outputted as a QR code or as plaintext, default plaintext.
