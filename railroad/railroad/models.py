# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=150, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    name = models.CharField(max_length=255, blank=True, null=True)
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)


class AuthUser(models.Model):
    password = models.CharField(max_length=128, blank=True, null=True)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.BooleanField()
    username = models.CharField(unique=True, max_length=150, blank=True, null=True)
    first_name = models.CharField(max_length=150, blank=True, null=True)
    last_name = models.CharField(max_length=150, blank=True, null=True)
    email = models.CharField(max_length=254, blank=True, null=True)
    is_staff = models.BooleanField()
    is_active = models.BooleanField()
    date_joined = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'auth_user'


class AuthUserGroups(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_groups'
        unique_together = (('user', 'group'),)


class AuthUserUserPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_user_permissions'
        unique_together = (('user', 'permission'),)


class Direction(models.Model):
    id = models.BigIntegerField(primary_key=True)
    name = models.CharField(max_length=50)

    class Meta:
        managed = False
        db_table = 'direction'


class DirectionPlan(models.Model):
    id = models.BigIntegerField(primary_key=True)
    station = models.ForeignKey('Station', models.DO_NOTHING)
    direction = models.ForeignKey(Direction, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'direction_plan'


class DjangoAdminLog(models.Model):
    action_time = models.DateTimeField()
    object_id = models.TextField(blank=True, null=True)
    object_repr = models.CharField(max_length=200, blank=True, null=True)
    action_flag = models.IntegerField()
    change_message = models.TextField(blank=True, null=True)
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'django_admin_log'


class DjangoContentType(models.Model):
    app_label = models.CharField(max_length=100, blank=True, null=True)
    model = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    id = models.BigAutoField(primary_key=True)
    app = models.CharField(max_length=255, blank=True, null=True)
    name = models.CharField(max_length=255, blank=True, null=True)
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40)
    session_data = models.TextField(blank=True, null=True)
    expire_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_session'


class Link(models.Model):
    id = models.BigIntegerField(primary_key=True)
    in_field = models.ForeignKey('Station', models.DO_NOTHING, db_column='in_id',related_name='in_station')  # Field renamed because it was a Python reserved word.
    out = models.ForeignKey('Station', models.DO_NOTHING,related_name='out_station')
    travel_time = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'link'


class Point(models.Model):
    id = models.BigIntegerField(primary_key=True)
    arrival_time = models.CharField(max_length=5)
    departure_time = models.CharField(max_length=5)
    station = models.ForeignKey('Station', models.DO_NOTHING)
    route = models.ForeignKey('Route', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'point'


class Route(models.Model):
    id = models.BigIntegerField(primary_key=True)
    route_date = models.DateField()
    name = models.CharField(max_length=100)
    train = models.ForeignKey('Train', models.DO_NOTHING)
    direction = models.ForeignKey(Direction, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'route'


class Station(models.Model):
    id = models.BigIntegerField(primary_key=True)
    name = models.CharField(max_length=60)
    zone = models.ForeignKey('Zone', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'station'


class Ticket(models.Model):
    id = models.BigIntegerField(primary_key=True)
    price = models.DecimalField(max_digits=5, decimal_places=2)
    purchase_date = models.DateField()
    arrival_station = models.ForeignKey(Station, models.DO_NOTHING,related_name='arrival_station')
    departure_station = models.ForeignKey(Station, models.DO_NOTHING,name='departure_station')

    class Meta:
        managed = False
        db_table = 'ticket'


class Train(models.Model):
    id = models.BigIntegerField(primary_key=True)
    name = models.CharField(max_length=20)

    class Meta:
        managed = False
        db_table = 'train'


class Zone(models.Model):
    id = models.BigIntegerField(primary_key=True)
    name = models.CharField(max_length=50)
    price = models.DecimalField(max_digits=5, decimal_places=2)

    class Meta:
        managed = False
        db_table = 'zone'
