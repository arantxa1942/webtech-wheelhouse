
RepairService.delete_all
Repair.delete_all
Bike.delete_all
Customer.delete_all
StaffMember.delete_all
Service.delete_all

Service.create!([
  { name: "Brake or gear adjustment", price: 10_000 },
  { name: "Installation of accessories", price: 15_000 },
  { name: "Wheel truing", price: 10_000 },
  { name: "Minor mechanical repairs", price: 10_000 },
  { name: "Chain installation", price: 4_000 },
  { name: "Handlebar installation", price: 4_000 },
  { name: "Bike wash", price: 18_000 },
  { name: "Wheel assembly", price: 20_000 },
  { name: "Insert installation (each wheel)", price: 3_000 },
  { name: "Bicycle assembly", price: 20_000 },
  { name: "Complete transmission installation", price: 10_000 },
  { name: "Sprocket/cassette installation", price: 4_000 },
  { name: "Flat tire repair", price: 6_000 },
  { name: "Inner tube replacement", price: 5_000 },
  { name: "Brake pad replacement", price: 8_000 },
  { name: "Chain lubrication", price: 3_000 },
  { name: "Bearing adjustment", price: 9_000 },
  { name: "Pedal installation", price: 5_000 },
  { name: "Full safety inspection", price: 12_000 },
  { name: "Suspension adjustment", price: 14_000 }
])

maria = StaffMember.create!(name: "María González", role: "Mechanic")
diego = StaffMember.create!(name: "Diego Rojas", role: "Mechanic")
camila = StaffMember.create!(name: "Camila Soto", role: "Mechanic")
valentina = StaffMember.create!(name: "Valentina Pérez", role: "Counter staff")

ana = Customer.create!(name: "Ana Morales", phone: "+56 9 6123 4501")
carlos = Customer.create!(name: "Carlos Fuentes", phone: "+56 9 7234 5612")
sofia = Customer.create!(name: "Sofía Ramírez", phone: "+56 9 8345 6723")
matias = Customer.create!(name: "Matías Herrera", phone: "+56 9 9456 7834")
valeria = Customer.create!(name: "Valeria Castillo", phone: "+56 9 5567 8945")
pablo = Customer.create!(name: "Pablo Contreras", phone: "+56 9 6678 9056")
fernanda = Customer.create!(name: "Fernanda Ríos", phone: "+56 9 7789 0167")
tomas = Customer.create!(name: "Tomás Aguilera", phone: "+56 9 8890 1278")
camila_customer = Customer.create!(name: "Camila Vega", phone: "+56 9 9901 2389")
javier = Customer.create!(name: "Javier Muñoz", phone: "+56 9 4012 3490")

Bike.create!([
  {
    customer_id: ana.id,
    make: "Trek",
    model: "Marlin 6",
    color: "Blue",
    serial_number: "TRK-M6-2024-001"
  },
  {
    customer_id: ana.id,
    make: "Giant",
    model: "Escape 3",
    color: "Black",
    serial_number: "GNT-E3-2023-014"
  },
  {
    customer_id: carlos.id,
    make: "Specialized",
    model: "Rockhopper",
    color: "Red",
    serial_number: "SPZ-RH-2022-031"
  },
  {
    customer_id: sofia.id,
    make: "Trek",
    model: "FX 2",
    color: "White",
    serial_number: "TRK-FX2-2024-018"
  },
  {
    customer_id: matias.id,
    make: "Oxford",
    model: "Merak",
    color: "Gray",
    serial_number: "OXF-MRK-2021-052"
  },
  {
    customer_id: valeria.id,
    make: "Bianchi",
    model: "Via Nirone",
    color: "Green",
    serial_number: "BNC-VN-2020-009"
  },
  {
    customer_id: pablo.id,
    make: "Trek",
    model: "FX 2",
    color: "White",
    serial_number: "TRK-FX2-2024-019"
  },
  {
    customer_id: fernanda.id,
    make: "Cannondale",
    model: "Quick 4",
    color: "Yellow",
    serial_number: "CND-Q4-2023-027"
  },
  {
    customer_id: tomas.id,
    make: "Scott",
    model: "Aspect 930",
    color: "Orange",
    serial_number: "SCT-A930-2022-016"
  },
  {
    customer_id: camila_customer.id,
    make: "Merida",
    model: "Big Nine",
    color: "Black",
    serial_number: "MRD-B9-2024-006"
  },
  {
    customer_id: javier.id,
    make: "Giant",
    model: "Talon 2",
    color: "Blue",
    serial_number: "GNT-T2-2023-041"
  },
  {
    customer_id: carlos.id,
    make: "Orbea",
    model: "Vector 20",
    color: "Silver",
    serial_number: "ORB-V20-2021-035"
  }
])
today = Date.current

marlin = Bike.find_by!(serial_number: "TRK-M6-2024-001")
escape = Bike.find_by!(serial_number: "GNT-E3-2023-014")
rockhopper = Bike.find_by!(serial_number: "SPZ-RH-2022-031")
trek_fx_sofia = Bike.find_by!(serial_number: "TRK-FX2-2024-018")
merak = Bike.find_by!(serial_number: "OXF-MRK-2021-052")
bianchi = Bike.find_by!(serial_number: "BNC-VN-2020-009")
trek_fx_pablo = Bike.find_by!(serial_number: "TRK-FX2-2024-019")
quick = Bike.find_by!(serial_number: "CND-Q4-2023-027")
scott = Bike.find_by!(serial_number: "SCT-A930-2022-016")
merida = Bike.find_by!(serial_number: "MRD-B9-2024-006")
orbea = Bike.find_by!(serial_number: "ORB-V20-2021-035")

repair_1 = Repair.create!(
  bike_id: marlin.id, staff_member_id: maria.id, status: "in_progress",
  received_at: 8.days.ago, quoted_at: 7.days.ago,
  customer_response: "approved", customer_responded_at: 7.days.ago,
  promised_on: today - 2.days
)

repair_2 = Repair.create!(
  bike_id: escape.id, staff_member_id: diego.id, status: "returned",
  received_at: 12.days.ago.change(hour: 9),
  quoted_at: 12.days.ago.change(hour: 10),
  customer_response: "approved", customer_responded_at: 12.days.ago.change(hour: 11),
  promised_on: today - 12.days,
  returned_at: 12.days.ago.change(hour: 17)
)

repair_3 = Repair.create!(
  bike_id: rockhopper.id, status: "declined",
  received_at: 6.days.ago, quoted_at: 5.days.ago,
  customer_response: "declined", customer_responded_at: 5.days.ago
)

repair_4 = Repair.create!(
  bike_id: trek_fx_sofia.id, status: "received",
  received_at: 2.days.ago
)

repair_5 = Repair.create!(
  bike_id: merak.id, staff_member_id: camila.id, status: "quoted",
  received_at: 4.days.ago, quoted_at: 3.days.ago,
  promised_on: today + 3.days
)

repair_6 = Repair.create!(
  bike_id: bianchi.id, staff_member_id: maria.id, status: "approved",
  received_at: 5.days.ago, quoted_at: 4.days.ago,
  customer_response: "approved", customer_responded_at: 4.days.ago,
  promised_on: today + 2.days
)

repair_7 = Repair.create!(
  bike_id: trek_fx_pablo.id, staff_member_id: diego.id, status: "ready_for_pickup",
  received_at: 7.days.ago, quoted_at: 6.days.ago,
  customer_response: "approved", customer_responded_at: 6.days.ago,
  promised_on: today
)

repair_8 = Repair.create!(
  bike_id: quick.id, staff_member_id: camila.id, status: "returned",
  received_at: 20.days.ago, quoted_at: 19.days.ago,
  customer_response: "approved", customer_responded_at: 19.days.ago,
  promised_on: today - 18.days, returned_at: 18.days.ago
)

repair_9 = Repair.create!(
  bike_id: scott.id, staff_member_id: maria.id, status: "in_progress",
  received_at: 3.days.ago, quoted_at: 2.days.ago,
  customer_response: "approved", customer_responded_at: 2.days.ago,
  promised_on: today + 4.days
)

repair_10 = Repair.create!(
  bike_id: merida.id, staff_member_id: diego.id, status: "ready_for_pickup",
  received_at: 10.days.ago, quoted_at: 9.days.ago,
  customer_response: "approved", customer_responded_at: 9.days.ago,
  promised_on: today - 1.day
)

repair_11 = Repair.create!(
  bike_id: orbea.id, status: "received",
  received_at: 1.day.ago
)

old_received_at = (today.beginning_of_year - 30.days).to_time.change(hour: 9)

repair_12 = Repair.create!(
  bike_id: marlin.id, staff_member_id: camila.id, status: "returned",
  received_at: old_received_at, quoted_at: old_received_at + 1.hour,
  customer_response: "approved", customer_responded_at: old_received_at + 2.hours,
  promised_on: old_received_at.to_date + 2.days,
  returned_at: old_received_at + 2.days + 6.hours
)

repair_13 = Repair.create!(
  bike_id: escape.id, staff_member_id: maria.id, status: "approved",
  received_at: 14.days.ago, quoted_at: 13.days.ago,
  customer_response: "approved", customer_responded_at: 13.days.ago,
  promised_on: today + 1.day
)

repair_14 = Repair.create!(
  bike_id: bianchi.id, staff_member_id: diego.id, status: "quoted",
  received_at: 2.days.ago, quoted_at: 1.day.ago,
  promised_on: today + 5.days
)

repair_15 = Repair.create!(
  bike_id: quick.id, status: "declined",
  received_at: 16.days.ago, quoted_at: 15.days.ago,
  customer_response: "declined", customer_responded_at: 15.days.ago
)

brake_adjustment = Service.find_by!(name: "Brake or gear adjustment")
chain_installation = Service.find_by!(name: "Chain installation")
flat_tire_repair = Service.find_by!(name: "Flat tire repair")
wheel_truing = Service.find_by!(name: "Wheel truing")
brake_pads = Service.find_by!(name: "Brake pad replacement")
full_inspection = Service.find_by!(name: "Full safety inspection")
bearing_adjustment = Service.find_by!(name: "Bearing adjustment")
bike_wash = Service.find_by!(name: "Bike wash")
wheel_assembly = Service.find_by!(name: "Wheel assembly")
inner_tube = Service.find_by!(name: "Inner tube replacement")
suspension = Service.find_by!(name: "Suspension adjustment")
pedal_installation = Service.find_by!(name: "Pedal installation")
bicycle_assembly = Service.find_by!(name: "Bicycle assembly")
transmission = Service.find_by!(name: "Complete transmission installation")
accessories = Service.find_by!(name: "Installation of accessories")
sprocket = Service.find_by!(name: "Sprocket/cassette installation")

RepairService.create!([
  { repair_id: repair_1.id, service_id: brake_adjustment.id, charged_price: 10_000 },
  { repair_id: repair_1.id, service_id: chain_installation.id, charged_price: 3_500 },

  { repair_id: repair_2.id, service_id: flat_tire_repair.id, charged_price: 6_000 },

  { repair_id: repair_3.id, service_id: wheel_truing.id, charged_price: 10_000 },
  { repair_id: repair_3.id, service_id: brake_pads.id, charged_price: 8_000 },

  { repair_id: repair_4.id, service_id: full_inspection.id, charged_price: 12_000 },

  { repair_id: repair_5.id, service_id: bearing_adjustment.id, charged_price: 9_000 },

  { repair_id: repair_6.id, service_id: bike_wash.id, charged_price: 18_000 },
  { repair_id: repair_6.id, service_id: wheel_assembly.id, charged_price: 20_000 },

  { repair_id: repair_7.id, service_id: brake_adjustment.id, charged_price: 8_000 },

  { repair_id: repair_8.id, service_id: inner_tube.id, charged_price: 5_000 },
  { repair_id: repair_8.id, service_id: flat_tire_repair.id, charged_price: 6_000 },

  { repair_id: repair_9.id, service_id: suspension.id, charged_price: 14_000 },
  { repair_id: repair_9.id, service_id: chain_installation.id, charged_price: 4_000 },

  { repair_id: repair_10.id, service_id: pedal_installation.id, charged_price: 5_000 },
  { repair_id: repair_10.id, service_id: wheel_assembly.id, charged_price: 20_000 },

  { repair_id: repair_11.id, service_id: full_inspection.id, charged_price: 12_000 },

  { repair_id: repair_12.id, service_id: brake_adjustment.id, charged_price: 8_500 },
  { repair_id: repair_12.id, service_id: bicycle_assembly.id, charged_price: 17_000 },

  { repair_id: repair_13.id, service_id: transmission.id, charged_price: 10_000 },

  { repair_id: repair_14.id, service_id: accessories.id, charged_price: 15_000 },

  { repair_id: repair_15.id, service_id: sprocket.id, charged_price: 4_000 }
])
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
