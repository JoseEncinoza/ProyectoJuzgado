<?php

/*
 * Copyright (c) e-binaria <info@e-binaria.com.ar>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

use Symfony\Component\HttpKernel\Kernel;
use Symfony\Component\Config\Loader\LoaderInterface;

class AppKernel extends Kernel
{
    public function registerBundles()
    {
        $bundles = [

            # Symfony
            new Symfony\Bundle\FrameworkBundle\FrameworkBundle(),
            new Symfony\Bundle\SecurityBundle\SecurityBundle(),
            new Symfony\Bundle\TwigBundle\TwigBundle(),
            new Symfony\Bundle\MonologBundle\MonologBundle(),
            new Symfony\Bundle\SwiftmailerBundle\SwiftmailerBundle(),
            new Doctrine\Bundle\DoctrineBundle\DoctrineBundle(),
            new Sensio\Bundle\FrameworkExtraBundle\SensioFrameworkExtraBundle(),

            # third-party bundles
            new FOS\JsRoutingBundle\FOSJsRoutingBundle(),
            new Stof\DoctrineExtensionsBundle\StofDoctrineExtensionsBundle(),

            # e-binaria - DNA Core
            new Dna\Core\Bundle\DnaCoreBundle(),
            new Dna\Core\Data\DnaCoreData(),
            new Dna\Core\Locale\DnaCoreLocale(),
            new Dna\Core\Markdown\DnaCoreMarkdown(),
            new Dna\Core\Media\DnaCoreMedia(),
            new Dna\Core\Renderer\DnaCoreRenderer(),
            new Dna\Core\Storage\DnaCoreStorage(),
            new Dna\Core\Email\DnaCoreEmail(),
            new Dna\Core\Audit\DnaCoreAudit(),

            # e-binaria - DNA Core UI
            new Dna\Core\Ui\DataGrid\DnaCoreUiDataGrid(),
            new Dna\Core\Ui\Menu\DnaCoreUiMenu(),
            new Dna\Core\Ui\Notification\DnaCoreUiNotification(),

            # e-binaria - DNA Adpater
            new Dna\Adapter\Select2\DnaAdapterSelect2(),
            new Dna\Adapter\Htmltopdf\DnaAdapterHtmltopdf(),
            new Dna\Adapter\Tcpdf\DnaAdapterTcpdf(),
            new Dna\Adapter\Phpexcel\DnaAdapterPhpexcel(),

            # e-binaria - DNA Common
            new Dna\Common\Crontask\DnaCommonCrontask(),
            new Dna\Common\Identity\DnaCommonIdentity(),
            new Dna\Common\Setting\DnaCommonSetting(),
            new Dna\Common\Template\DnaCommonTemplate(),
			new Dna\Common\Notification\DnaCommonNotification(),
			new Dna\Common\Email\DnaCommonEmail(),
			new Dna\Common\Message\DnaCommonMessage(),

            # e-binaria - DNA Admin application
            new Dna\Admin\Base\DnaAdminBaseBundle(),
            new Dna\Admin\Base\Notification\DnaAdminBaseNotificationBundle(),
            new Dna\Admin\Crontask\DnaAdminCrontaskBundle(),
            new Dna\Admin\Setting\DnaAdminSettingBundle(),
            new Dna\Admin\Template\DnaAdminTemplateBundle(),
            new Dna\Admin\Notification\DnaAdminNotificationBundle(),
            new Dna\Admin\Message\DnaAdminMessageBundle(),
            new Dna\Admin\Audit\DnaAdminAuditBundle(),

            # mlp - Admin juzgado
            new Juzgado\Admin\Base\JuzgadoAdminBaseBundle(),
            new Juzgado\Admin\Vehiculo\JuzgadoAdminVehiculoBundle(),
            new Juzgado\Common\Vehiculo\JuzgadoCommonVehiculo(),
            new Juzgado\Admin\Persona\JuzgadoAdminPersonaBundle(),
            new Juzgado\Common\Persona\JuzgadoCommonPersona(),
            new Juzgado\Admin\Empleado\JuzgadoAdminEmpleadoBundle(),
            new Juzgado\Common\Empleado\JuzgadoCommonEmpleado(),
            new Juzgado\Admin\Expediente\JuzgadoAdminExpedienteBundle(),
            new Juzgado\Common\Expediente\JuzgadoCommonExpediente(),
            new Juzgado\Admin\Acta\JuzgadoAdminActaBundle(),
            new Juzgado\Common\Acta\JuzgadoCommonActa(),
            new Juzgado\Admin\Feriado\JuzgadoAdminFeriadoBundle(),
            new Juzgado\Common\Feriado\JuzgadoCommonFeriado(),
            new Juzgado\Admin\LibreDeuda\JuzgadoAdminLibreDeudaBundle(),
            new Juzgado\Common\LibreDeuda\JuzgadoCommonLibreDeuda(),
            new Juzgado\Admin\Notificacion\JuzgadoAdminNotificacionBundle(),
            new Juzgado\Common\Notificacion\JuzgadoCommonNotificacion(),
            new Juzgado\Admin\Sentencia\JuzgadoAdminSentenciaBundle(),
            new Juzgado\Common\Sentencia\JuzgadoCommonSentencia(),

            # e-binaria - DNA Web application
            new Dna\Web\Base\DnaWebBaseBundle(),

            # App Web
            new App\Web\Base\AppWebBaseBundle()

        ];

        if (in_array($this->getEnvironment(), ['dev', 'test'], true)) {
            $bundles[] = new Symfony\Bundle\DebugBundle\DebugBundle();
            $bundles[] = new Symfony\Bundle\WebProfilerBundle\WebProfilerBundle();
            $bundles[] = new Sensio\Bundle\DistributionBundle\SensioDistributionBundle();

            if ('dev' === $this->getEnvironment()) {
                $bundles[] = new Sensio\Bundle\GeneratorBundle\SensioGeneratorBundle();
                $bundles[] = new Symfony\Bundle\WebServerBundle\WebServerBundle();
            }
        }

        return $bundles;
    }

    public function getRootDir()
    {
        return __DIR__;
    }

    public function getCacheDir()
    {
        return realpath(__DIR__ . '/..') . '-data/var/cache/' . $this->getEnvironment();
    }

    public function getLogDir()
    {
        return realpath(__DIR__ . '/..') . '-data/var/logs/' . $this->getEnvironment();
    }

    public function registerContainerConfiguration(LoaderInterface $loader)
    {
        $loader->load($this->getRootDir().'/config/config_'.$this->getEnvironment().'.yml');
    }
}
