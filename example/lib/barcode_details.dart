import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_barcode.dart';

class BarCodeDetails extends StatelessWidget {
  final Barcode barcode;
  const BarCodeDetails({Key key, this.barcode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Details'),
      ),
      body: ListView(
        children: getChildrens(),
      ),
    );
  }

  getChildrens() {
    List<Widget> widgets = List<Widget>();

    switch (barcode.valueType) {
      case BarcodeValueType.text:
        {
          widgets.add(ListTile(
              title: Text(
                'Display Value',
              ),
              subtitle: Text(
                barcode.displayValue,
              )));
          widgets.add(ListTile(
              title: Text(
                'Raw Value',
              ),
              subtitle: Text(
                barcode.rawValue,
              )));
          widgets.add(ListTile(
              title: Text(
                'Format',
              ),
              subtitle: Text(
                barcode.format.toString(),
              )));
          widgets.add(getBoundinfBoxWidget());
          widgets.add(getCornerPointsWidget());
          return widgets;
        }
        break;

      case BarcodeValueType.contactInfo:
        {
          widgets.add(ListTile(
            title: Text(
              'Display Value',
            ),
            subtitle: Text(barcode.displayValue),
          ));
          widgets.add(ListTile(
              title: Text(
                'Raw Value',
              ),
              subtitle: Text(
                barcode.rawValue,
              )));
          widgets.add(ListTile(
              title: Text(
                'Format',
              ),
              subtitle: Text(
                barcode.format.toString(),
              )));
          widgets.add(getBoundinfBoxWidget());
          widgets.add(getCornerPointsWidget());
          widgets.add(ListTile(
            title: Text('Job Title'),
            subtitle: Text(barcode.contactInfo.jobTitle),
          ));
          widgets.add(ListTile(
            title: Text('Organization'),
            subtitle: Text(barcode.contactInfo.organization),
          ));
          widgets.add(
            ExpansionTile(
              title: Text(
                "Name",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              children: [
                ListTile(
                  title: Text(
                    'Formatted Name',
                  ),
                  subtitle: Text(barcode.contactInfo.name.formattedName),
                ),
                ListTile(
                  title: Text(
                    'First Name',
                  ),
                  subtitle: Text(barcode.contactInfo.name.first),
                ),
                ListTile(
                  title: Text(
                    'Last Name',
                  ),
                  subtitle: Text(barcode.contactInfo.name.last),
                ),
                ListTile(
                  title: Text(
                    'Middele Name',
                  ),
                  subtitle: Text(barcode.contactInfo.name.middle),
                ),
                ListTile(
                  title: Text(
                    'Prefix',
                  ),
                  subtitle: Text(barcode.displayValue),
                ),
                ListTile(
                  title: Text(
                    'Suffix',
                  ),
                  subtitle: Text(barcode.displayValue),
                ),
                ListTile(
                  title: Text(
                    'Pronunciation',
                  ),
                  subtitle: Text(barcode.displayValue),
                )
              ],
            ),
          );
          widgets.add(
            ExpansionTile(
                title: Text('Address', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                children: barcode.contactInfo.addresses
                    .map((e) => ListTile(
                          title: Text(e.addressLines.join(',')),
                          trailing: Text(e.type.index == 0
                              ? 'UNKNOWN'
                              : e.type.index == 1
                                  ? 'WORK'
                                  : 'Home'),
                        ))
                    .toList()),
          );
          widgets.add(ExpansionTile(
            title: Text('Emails', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            children: barcode.contactInfo.emails
                .map((e) => ListTile(
                      isThreeLine: true,
                      title: Text(e.address),
                      subtitle: Column(
                        children: [
                          Text(e.subject),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(e.body),
                          )
                        ],
                      ),
                      trailing: Text(e.type == BarcodeEmailType.unknown
                          ? 'UNKNOWN'
                          : e.type == BarcodeEmailType.work
                              ? 'WORK'
                              : ''),
                    ))
                .toList(),
          ));

          widgets.add(ExpansionTile(
            title: Text('Phones', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            children: barcode.contactInfo.phones
                .map((e) => ListTile(
                    title: Text(e.number),
                    trailing: Text(e.type.index == 0
                        ? 'UNKNOWN'
                        : e.type.index == 1
                            ? 'WORK'
                            : e.type.index == 2
                                ? 'HOME'
                                : e.type.index == 3
                                    ? "FAX"
                                    : 'MOBILE')))
                .toList(),
          ));

          widgets.add(ExpansionTile(
            title: Text('URLs', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            children: barcode.contactInfo.urls
                .map((e) => ListTile(
                      title: Text(e),
                    ))
                .toList(),
          ));

          return widgets;
        }
        break;
      case BarcodeValueType.email:
        {
          widgets.add(ListTile(
            title: Text('Display Value'),
            subtitle: Text(barcode.displayValue),
          ));
          widgets.add(ListTile(
            title: Text('Raw Value'),
            subtitle: Text(barcode.rawValue),
          ));

          widgets.add(ListTile(
              title: Text(
                'Format',
              ),
              subtitle: Text(
                barcode.format.toString(),
              )));
          widgets.add(getBoundinfBoxWidget());
          widgets.add(getCornerPointsWidget());
          widgets.add(ListTile(
            isThreeLine: true,
            title: Text(barcode.email.address),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(barcode.email.subject),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(barcode.email.body),
                )
              ],
            ),
            trailing: Text(barcode.email.type == BarcodeEmailType.unknown
                ? 'UNKNOWN'
                : barcode.email.type == BarcodeEmailType.work
                    ? 'WORK'
                    : ''),
          ));
          return widgets;
        }
        break;
      case BarcodeValueType.phone:
        {
          widgets.add(ListTile(
            title: Text('Display Value'),
            subtitle: Text(barcode.displayValue),
          ));
          widgets.add(ListTile(
            title: Text('Raw Value'),
            subtitle: Text(barcode.rawValue),
          ));

          widgets.add(ListTile(
              title: Text(
                'Format',
              ),
              subtitle: Text(
                barcode.format.toString(),
              )));
          widgets.add(getBoundinfBoxWidget());
          widgets.add(getCornerPointsWidget());
          widgets.add(ListTile(
            title: Text(barcode.phone.number),
            trailing: Text(barcode.phone.type == BarcodePhoneType.work
                ? 'WORK'
                : barcode.phone.type == BarcodePhoneType.home
                    ? 'HOME'
                    : barcode.phone.type == BarcodePhoneType.fax
                        ? 'FAX'
                        : barcode.phone.type == BarcodePhoneType.mobile
                            ? 'MOBILE'
                            : barcode.phone.type == BarcodePhoneType.mobile
                                ? 'MOBILE'
                                : 'UNKNOWN'),
          ));
          return widgets;
        }
        break;
      case BarcodeValueType.sms:
        {
          widgets.add(ListTile(
            title: Text('Display Value'),
            subtitle: Text(barcode.displayValue),
          ));
          widgets.add(ListTile(
            title: Text('Raw Value'),
            subtitle: Text(barcode.rawValue),
          ));

          widgets.add(ListTile(
              title: Text(
                'Format',
              ),
              subtitle: Text(
                barcode.format.toString(),
              )));
          widgets.add(getBoundinfBoxWidget());
          widgets.add(getCornerPointsWidget());
          widgets.add(ListTile(
            title: Text('Message'),
            subtitle: Text(barcode.sms.message),
          ));
          widgets.add(ListTile(
            title: Text('Phone Number'),
            subtitle: Text(barcode.sms.phoneNumber),
          ));
          return widgets;
        }
        break;
      case BarcodeValueType.url:
        {
          widgets.add(ListTile(
            title: Text('Display Value'),
            subtitle: Text(barcode.displayValue),
          ));
          widgets.add(ListTile(
            title: Text('Raw Value'),
            subtitle: Text(barcode.rawValue),
          ));

          widgets.add(ListTile(
              title: Text(
                'Format',
              ),
              subtitle: Text(
                barcode.format.toString(),
              )));
          widgets.add(getBoundinfBoxWidget());
          widgets.add(getCornerPointsWidget());
          widgets.add(ListTile(
            title: Text('Title'),
            subtitle: Text(barcode.url.title),
          ));
          widgets.add(ListTile(
            title: Text('URL'),
            subtitle: Text(barcode.url.url),
          ));
          return widgets;
        }
        break;
      case BarcodeValueType.wifi:
        {
          widgets.add(ListTile(
            title: Text('Display Value'),
            subtitle: Text(barcode.displayValue),
          ));
          widgets.add(ListTile(
            title: Text('Raw Value'),
            subtitle: Text(barcode.rawValue),
          ));

          widgets.add(ListTile(
              title: Text(
                'Format',
              ),
              subtitle: Text(
                barcode.format.toString(),
              )));
          widgets.add(getBoundinfBoxWidget());
          widgets.add(getCornerPointsWidget());
          widgets.add(ListTile(
            title: Text('SSID'),
            subtitle: Text(barcode.wifi.ssid),
          ));
          widgets.add(ListTile(
            title: Text('Password'),
            subtitle: Text(barcode.wifi.password),
          ));
          widgets.add(ListTile(
            title: Text('Type'),
            subtitle: Text(barcode.wifi.encryptionType.index == 1
                ? 'OPEN'
                : barcode.wifi.encryptionType.index == 2
                    ? 'WPA'
                    : barcode.wifi.encryptionType.index == 3
                        ? 'WEP'
                        : 'UNKNOWN'),
          ));
          return widgets;
        }
      case BarcodeValueType.geographicCoordinates:
        {
          widgets.add(ListTile(
            title: Text('Display Value'),
            subtitle: Text(barcode.displayValue),
          ));
          widgets.add(ListTile(
            title: Text('Raw Value'),
            subtitle: Text(barcode.rawValue),
          ));

          widgets.add(ListTile(
              title: Text(
                'Format',
              ),
              subtitle: Text(
                barcode.format.toString(),
              )));
          widgets.add(getBoundinfBoxWidget());
          widgets.add(getCornerPointsWidget());
          widgets.add(ListTile(
            title: Text('LATTITUDE'),
            subtitle: Text(barcode.geoPoint.latitude.toString()),
          ));
          widgets.add(ListTile(
            title: Text('LONGITUDE'),
            subtitle: Text(barcode.geoPoint.longitude.toString()),
          ));

          return widgets;
        }
      case BarcodeValueType.calendarEvent:
        {
          widgets.add(ListTile(
            title: Text('Display Value'),
            subtitle: Text(barcode.displayValue),
          ));
          widgets.add(ListTile(
            title: Text('Raw Value'),
            subtitle: Text(barcode.rawValue),
          ));

          widgets.add(ListTile(
              title: Text(
                'Format',
              ),
              subtitle: Text(
                barcode.format.toString(),
              )));
          widgets.add(getBoundinfBoxWidget());
          widgets.add(getCornerPointsWidget());
          widgets.add(ListTile(
            title: Text('Event Description'),
            subtitle: Text(barcode.calendarEvent.eventDescription),
          ));
          widgets.add(ListTile(
            title: Text('Location'),
            subtitle: Text(barcode.calendarEvent.location),
          ));
          widgets.add(ListTile(
            title: Text('Organizer'),
            subtitle: Text(barcode.calendarEvent.organizer),
          ));
          widgets.add(ListTile(
            title: Text('Status'),
            subtitle: Text(barcode.calendarEvent.status),
          ));
          widgets.add(ListTile(
            title: Text('Summary'),
            subtitle: Text(barcode.calendarEvent.summary),
          ));
          widgets.add(ListTile(
            title: Text('Start'),
            subtitle: Text(barcode.calendarEvent.start),
          ));
          widgets.add(ListTile(
            title: Text('End'),
            subtitle: Text(barcode.calendarEvent.end),
          ));

          return widgets;
        }
        break;
      case BarcodeValueType.driverLicense:
        {
          widgets.add(ListTile(
            title: Text('Display Value'),
            subtitle: Text(barcode.displayValue),
          ));
          widgets.add(ListTile(
            title: Text('Raw Value'),
            subtitle: Text(barcode.rawValue),
          ));

          widgets.add(ListTile(
              title: Text(
                'Format',
              ),
              subtitle: Text(
                barcode.format.toString(),
              )));
          widgets.add(getBoundinfBoxWidget());
          widgets.add(getCornerPointsWidget());
          widgets.add(ListTile(
            title: Text('First Name'),
            subtitle: Text(barcode.driverLicense.firstName),
          ));
          widgets.add(ListTile(
            title: Text('Middle Name'),
            subtitle: Text(barcode.driverLicense.middleName),
          ));
          widgets.add(ListTile(
            title: Text('Last Name'),
            subtitle: Text(barcode.driverLicense.lastName),
          ));
          widgets.add(ListTile(
            title: Text('First Name'),
            subtitle: Text(barcode.driverLicense.firstName),
          ));
          widgets.add(ListTile(
            title: Text('Gender'),
            subtitle: Text(barcode.driverLicense.gender),
          ));
          widgets.add(ListTile(
            title: Text('Address City'),
            subtitle: Text(barcode.driverLicense.addressCity),
          ));
          widgets.add(ListTile(
            title: Text('Address State'),
            subtitle: Text(barcode.driverLicense.addressState),
          ));
          widgets.add(ListTile(
            title: Text('Address Street '),
            subtitle: Text(barcode.driverLicense.addressStreet),
          ));
          widgets.add(ListTile(
            title: Text('Address Zip'),
            subtitle: Text(barcode.driverLicense.addressZip),
          ));
          widgets.add(ListTile(
            title: Text('Birth Date'),
            subtitle: Text(barcode.driverLicense.birthDate),
          ));
          widgets.add(ListTile(
            title: Text('Document Type'),
            subtitle: Text(barcode.driverLicense.documentType),
          ));
          widgets.add(ListTile(
            title: Text('License Number'),
            subtitle: Text(barcode.driverLicense.licenseNumber),
          ));
          widgets.add(ListTile(
            title: Text('Expiry Date'),
            subtitle: Text(barcode.driverLicense.expiryDate),
          ));

          widgets.add(ListTile(
            title: Text('Issuing Date'),
            subtitle: Text(barcode.driverLicense.issuingDate),
          ));
          widgets.add(ListTile(
            title: Text('Issuing Country'),
            subtitle: Text(barcode.driverLicense.issuingCountry),
          ));

          return widgets;
        }
        break;
      case BarcodeValueType.product:
        {
          widgets.add(ListTile(
              title: Text(
                'Display Value',
              ),
              subtitle: Text(
                barcode.displayValue,
              )));
          widgets.add(ListTile(
              title: Text(
                'Raw Value',
              ),
              subtitle: Text(
                barcode.rawValue,
              )));
          widgets.add(ListTile(
              title: Text(
                'Format',
              ),
              subtitle: Text(
                barcode.format.toString(),
              )));
          widgets.add(getBoundinfBoxWidget());
          widgets.add(getCornerPointsWidget());
          return widgets;
        }
        break;
      default:
        return widgets;
        break;
    }
  }

  getBoundinfBoxWidget() {
    return ListTile(
      title: Text(
        'BoundingBox',
      ),
      subtitle: Column(
        children: [
          Row(
            children: [Text('Top: '), Text(barcode.boundingBox.top.toString())],
          ),
          Row(
            children: [Text('Bottom: '), Text(barcode.boundingBox.bottom.toString())],
          ),
          Row(
            children: [Text('Left: '), Text(barcode.boundingBox.left.toString())],
          ),
          Row(
            children: [Text('Right: '), Text(barcode.boundingBox.right.toString())],
          )
        ],
      ),
    );
  }

  getCornerPointsWidget() {
    return ListTile(
      title: Text(
        'Corner Points',
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: barcode.cornerPoints.map((e) => Text(e.toString())).toList(),
      ),
    );
  }
}
